---
pretitle: The
title: RISC-ViO
subtitle: Specification
version: DRAFT V0.3.2
lang: en
authors:
  - name: Leyla Jazz Ekinci (*B.Sc.*)
    affiliation: University of Stuttgart, IKR
    location: Stuttgart, Germany
    email: leylknci@ikr.uni-stuttgart.de
  - name: Robin Lux (*B.Sc.*)
    affiliation: University of Stuttgart, IKR
    location: Stuttgart, Germany
    email: rbnlux@ikr.uni-stuttgart.de
---

<!--
  Open points:
  * 'types' -> 'kinds': still under discussion. Preferably two different words,
    one for object kinds and one for register contents (pointer vs. primitive).
-->

::: legend
This document is split into two categories:

- [ISA]{.swatch .isa}
- [Implementation]{.swatch .imp}

Whenever a chapter is highlighted in [*ISA*]{.isa} colors, an abstract ISA-Layer concept is being described.
The [*Implementation*]{.imp} sections then cover specifics on how these concepts [*could*]{.imp}
be realized.
:::

:::::: isa

# Introduction {#intro}

RISC-ViO is a processor architecture in which memory consists of objects instead of bytes.
At every moment, the hardware knows for every register and every XLEN-wide element of memory whether it holds a *pointer* or a *primitive*, and every pointer names the object it belongs to.
From this one piece of knowledge, RISC-ViO derives protections that conventional architectures can only approximate with separate mechanisms:
every access is checked against the bounds of its object, pointers cannot be forged, code can neither be read nor written, a function cannot touch a frame it does not own, a return address can be used only once,
and memory is reclaimed by exact garbage collection instead of by *free*, which rules out use-after-free errors by construction.

RISC-ViO provides these protections without giving up the memory model of C. Pointers stay XLEN bits wide, pointer arithmetic works as C programs expect, and data structures keep their layout.
The architecture is defined as a modification of the RISC-V base integer ISA, called I', together with the *zhm* extension.

<!-- FIXME: explain the name 'RISC-ViO' in one sentence. Readers currently have to guess what 'ViO' stands for. -->

## Motivation {#motivation}

### Hardware that does not know what a pointer is {#motivation_problem}

Conventional architectures treat memory as a flat array of bytes. The objects a program is made of, like structs, arrays, heap allocations or stack frames, exist only in the compiler and in the language runtime.
While executing an instruction, the hardware knows neither where these objects begin and end, nor whether a register holds a pointer or an integer that merely has the same value.
It therefore cannot check whether an access stays inside its object, cannot distinguish a valid pointer from a forged one and cannot tell which memory is still in use.

In C and C++, this lack of information is the root of the most damaging class of software defects.
In the Chromium project, around 70% of serious security bugs are memory safety problems, and about half of those are use-after-free errors[^chromium_ms].
Microsoft reports the same share of 70% for the vulnerabilities it assigns a CVE[^msrc].
Buffer overflows, use-after-free, double free, forged pointers and overwritten return addresses look like different bugs, but they share a single cause:
the machine executing the program has no notion of the objects the program consists of.

### Existing answers {#motivation_existing}

Three kinds of answers to this problem exist today. Memory-safe languages replace the vulnerable code, memory tagging protects it with hardware that is already shipping in consumer devices,
and capability architectures make it memory safe by changing what a pointer is. Of these, CHERI is the approach any architecture promising memory safety for C, including RISC-ViO, has to be measured against.

#### Memory-safe languages {#motivation_languages}

Java, C#, Go or Python keep track of pointers and object bounds in their runtime, which costs bounds checks, type checks and a garbage collector that has to find pointers using metadata maintained in software.
Rust moves most of the cost to compile time, at the price of a strict ownership discipline.
None of them protects the existing code base: operating systems, browsers, libraries and firmware written in C and C++ will not be rewritten within the lifetime of the hardware being designed today.

#### Memory tagging {#motivation_tagging}

Memory tagging protects this existing code without rewriting it. Arm's Memory Tagging Extension (MTE) assigns a 4-bit tag to every 16-byte granule of memory and places a matching tag in the unused top bits of every pointer[^mte].
On every access, the hardware compares both tags and faults on a mismatch. Allocators choose a random tag for every allocation and a new one when it is freed, so out-of-bounds accesses and stale pointers are caught as long as the tags differ.
Memory tagging is the only hardware memory safety mechanism that has made it into consumer devices today [^tiktag][^apple_mie][^riscv_mt].

Its protection is probabilistic, however. With 4-bit tags, an access through a wrong pointer goes unnoticed whenever both tags happen to match, which is the case for about one in sixteen random tags.
An attacker who can retry, or learn the tags, defeats it: the TikTag attack leaks MTE tags through speculative execution and bypassed MTE in Google Chrome and the Linux kernel[^tiktag].
Memory tagging also does not identify pointers. A tag is just a few bits of the pointer, so any integer with the right address and the right tag is a valid pointer, and pointer integrity rests entirely on keeping the tags secret.
Bounds are only as fine as the 16-byte granules, and a stale pointer becomes valid again once its memory is reallocated with the same tag.
Turning memory tagging from a debugging aid into a defence therefore requires additional layers. Apple's Memory Integrity Enforcement, for example, permits only synchronous tag checking and combines it with type-segregated allocators and dedicated measures to keep tags confidential[^apple_mie].
Control flow needs separate extensions on top: shadow stacks and landing pads (RISC-V Zicfiss and Zicfilp, Arm PAC and BTI, Intel CET) protect returns and indirect jumps, but no data.

#### Capabilities: CHERI {#motivation_cheri}

CHERI[^cheri], developed at the University of Cambridge and SRI International for more than fifteen years, replaces pointers by capabilities.
A capability holds an address together with the bounds and permissions of the memory it may access, and a tag bit kept outside the addressable memory marks it as valid.
New capabilities can only be derived from existing ones with equal or smaller bounds and permissions, and overwriting a capability with data clears its tag, so capabilities cannot be forged.
CHERI makes C and C++ deterministically and spatially memory safe, can narrow bounds down to individual fields of a struct, and supports fine-grained compartmentalisation.
It runs on Arm's Morello prototype and on CHERIoT microcontrollers, and its RISC-V version, RVY, is on its way to standardisation[^cheri_rvy]. CHERI is the most mature answer to memory safety for C today.

CHERI's central design decision is to attach protection to the pointer: every capability carries its own bounds and permissions, and every copy of a capability is an independent authority to access memory.
Most of CHERI's costs follow from this one decision:

- **Wider pointers.** Bounds and permissions next to the address make a capability twice as wide as an address, 128 bits on RV64.
  Pointers are part of a program's data as much as of its code, so every structure holding a pointer changes its size, alignment and layout, and so does every interface that fixes such a layout, from system calls to file formats and buffers shared with devices.
  Pointer-heavy programs, like interpreters, compilers or anything built on linked data structures, need correspondingly more memory and cache.
- **Compressed bounds.** To fit into these 128 bits, bounds are stored in compressed form[^cheri_concentrate]. Large allocations get exact bounds only if their size and alignment are rounded accordingly,
  and a pointer moved too far outside its object can no longer be represented and loses its tag.
- **Tags throughout the memory system.** Since any capability-sized word may hold a capability, its tag has to travel with it through every cache level, the interconnect and the memory controller, which typically keeps the tags of main memory in a separate table.
  Caching this table keeps the additional memory traffic low[^joannou_tags], but the tags reach into components far outside the processor core, and writes by any agent, DMA engines included, have to clear them.
- **Revocation instead of temporal safety.** Since every copy of a capability is an independent authority and C's *free* is kept, freeing memory does not withdraw access to it.
  Freed memory has to stay in quarantine until a revocation sweep has found and invalidated every capability still pointing into it[^cornucopia]. Temporal safety is thus a mechanism added on top of the capability model rather than a consequence of it.

### The gap RISC-ViO fills {#motivation_gap}

None of the approaches that are deployed or being standardised offers deterministic spatial and temporal memory safety for C and C++ while leaving pointers, data layouts and the memory system as they are.
Memory tagging is probabilistic and leaves pointers forgeable. CHERI is deterministic, but pays for attaching protection to the pointer with wider pointers, tags throughout the memory system and revocation.

RISC-ViO fills this gap by attaching protection to the object instead.
It takes its inspiration from Objective-RISC[^meyer_orisc][^orisc_spec] (O-RISC), which raises the hardware to the level of objects: once the hardware knows which values are pointers and which objects they belong to, bounds checks, unforgeable pointers, protected frames and exact garbage collection follow from one model.
O-RISC realizes this idea for memory-safe, garbage-collected languages and deliberately leaves C aside. RISC-ViO brings it to C.

The key to this is a different notion of a pointer. A RISC-ViO pointer consists of a reference to an object and an *index* into this object.
Pointer arithmetic changes the index, never the reference. A pointer can therefore move freely inside its object and arbitrarily far beyond its bounds, just as C pointers do, but it can never be turned into a pointer to another object, and every access through it is checked against the bounds of the object it references.
Bounds and permissions exist once per object rather than in every pointer, so a pointer stays XLEN bits wide. Since the reference always names the head of the object, the hardware and the garbage collector find the object belonging to any pointer immediately, even if the pointer points into the middle of it.
And since objects are reclaimed by a garbage collector instead of being freed, there are no stale copies of a pointer left to hunt down.

::: figure
![Conventional architectures](svg/conv_obj_view.drawio.svg "a) Conventional architectures")
![O-RISC](svg/oriscv_obj_view.drawio.svg "b) O-RISC")
![RISC-ViO](svg/vio_obj_view.drawio.svg "c) RISC-ViO")

View of the different architectures on programming language level objects in memory
:::

## Design goals {#goals}

The approaches above leave five problems open, and RISC-ViO answers each of them with one design goal. A sixth goal decides how these answers are realised. The trade-offs these goals involve are summarised in [trade-offs](#tradeoffs).

#### 1. Deterministic protection from a single source

Today's hardware defences address one class of error per mechanism: tags against out-of-bounds accesses and stale pointers, revocation against use-after-free, shadow stacks against overwritten return addresses.
Each mechanism has gaps and costs of its own, and only their combination approaches complete protection. Where a defence is probabilistic, an attacker who can retry, or leak the secret it depends on, defeats it[^tiktag].

RISC-ViO therefore derives all of its memory protection from a single property: the hardware always knows whether a value is a pointer or a primitive, and to which object a pointer belongs.
Bounds checks, pointer integrity, the protection of frames and return addresses as well as garbage collection all follow from this knowledge.
The protection is deterministic. There is no probability of a missed violation, no secret to leak, no unchecked mode and no way for user code to opt out.

#### 2. Protection for the code that exists

A memory safety mechanism is only worth as much as the code it reaches. Writing new code in memory-safe languages markedly reduces the number of new vulnerabilities[^android_safe_coding],
but the existing code stays in service and keeps being changed, and operating systems, firmware and embedded software are still written in C and C++ today.
A mechanism that requires rewriting this code protects only what gets rewritten. A mechanism that changes the representation of pointers turns adoption into a porting project,
because pointers are part of a program's data as much as of its code: every structure, every interface and every binary format containing pointers changes with them.
And a machine that forbids interior pointers or pointer arithmetic cannot run C at all.

RISC-ViO therefore keeps C's pointer model exactly as C defines it. A pointer is XLEN bits wide, may point anywhere inside its object and even beyond it,
and supports the arithmetic and comparisons C programs use, including those that rely on pointer identity.
Since every data layout stays identical to RISC-V, existing code is protected by recompiling it, not by porting it.

#### 3. No free, no dangling pointers

In Chromium, use-after-free alone accounts for about half of all memory safety bugs[^chromium_ms]. The existing answers keep *free* and try to catch its consequences:
memory tagging detects stale pointers with some probability, and CHERI finds and invalidates them in revocation sweeps.
Conservative garbage collectors for C remove *free*, but since they have to treat every value that looks like a pointer as one, they can neither move objects nor rule out retaining memory by mistake[^boehm].

RISC-ViO therefore removes *free* altogether. Objects are reclaimed by a garbage collector once they can no longer be reached, so no pointer can ever dangle.
Since the hardware knows every pointer, the collector is exact and may move objects to compact the heap, and since every pointer names the head of its object, the collector finds the object belonging to any pointer immediately.
Allocation becomes a single instruction, and the allocator keeps no metadata in memory a program could corrupt.

#### 4. Cheap enough to stay on

A protection that costs noticeable performance gets weakened or switched off. Memory tagging offers an asynchronous checking mode for this reason, which reports a violation only after the access has taken place.
Protection that requires microcode, iterates over memory or extends every part of the memory system makes processors more complex and execution less predictable.

RISC-ViO therefore follows the RISC philosophy. No instruction performs work proportional to the size of an object or to the number of pointers it holds, and none requires microcode or iterates over memory.
The checks an access needs rely only on information held along with the pointer in the register file, so they can run in parallel to address generation, as they do in the execute stage of the example implementation.
Allocation takes constant time, because objects are allocated from memory that has already been cleared.
How pointers are distinguished from primitives in memory is left to the implementation. The example implementation encodes this distinction within each memory element, so caches, interconnect and main memory remain as they are.
This keeps RISC-ViO implementable in ordinary pipelines, from small embedded cores to superscalar designs.

#### 5. Build on RISC-V

An architecture is only useful for research and adoption if it can be built, programmed and compared. An ISA designed from scratch needs its own compilers, simulators and processor cores before its first program runs, and it makes a fair comparison with existing approaches hard.

RISC-ViO therefore builds on RISC-V and keeps everything of it the object model allows: the instruction encodings, the 32 general-purpose registers, little-endian data, the privilege modes, CSRs and traps, the assembler syntax and ELF.
It changes the semantics of base instructions only where objects require it, resulting in I', and adds the zhm extension.
RISC-V's openness permits such changes, its compilers, simulators and cores are freely available, and its standard extensions, like the landing pads of Zicfilp, can be combined with RISC-ViO.
Since CHERI and memory tagging are being standardised for RISC-V as well[^cheri_rvy][^riscv_mt], RISC-ViO can be compared to them on the same base ISA and with the same toolchains.

#### 6. Make the safe case fast

A protection that slows down what every program does all the time costs more than one that makes rare operations expensive.
This holds in particular for languages that are already memory safe, like Java, C# or Go. They pay for their safety in software today, with bounds checks, type checks and garbage collectors that find pointers using metadata maintained by the runtime.
On RISC-ViO, the hardware takes over this work, so these languages should run faster, not slower.

RISC-ViO therefore keeps the operations cheap that safe and unsafe languages perform constantly: calls and returns, saving and restoring registers including the return address, loads and stores of pointers to objects, bounds-checked accesses and allocation.
It accepts higher costs for operations which are rare in programs written in safe languages, like storing pointers into the middle of objects, ordering objects by identity or the privileged instructions of the system management software.
Where the safe way of doing something and the fast way differ, RISC-ViO makes the safe way the fast one.

## RISC-ViO at a glance {#overview}

This section gives an informal overview of the architecture as a whole. Every concept is specified precisely in the chapter it links to.

**Objects.** All memory a user mode program can access consists of objects: contiguous, bounded areas whose size is a multiple of XLEN/8 bytes.
User code creates objects with the instructions of the [alc family](#alc_fam), which return a pointer to a new object filled with the primitive value 0.
Every object carries tags. Its *kind* states what it may be used for: ordinary objects may hold pointers and primitives, data only objects hold primitives only, and executable objects hold instructions.
Its *permissions* state whether it may be read or written, and ordinary objects can be marked as *weak cells*, whose pointers do not keep the objects they reference alive.
I/O devices are accessed through pointers as well and carry the same tags ([objects and I/O devices](#objects_devices), [object tags](#isa_tags)).

**Pointers and primitives.** Every register and every XLEN-wide element of an object holds either a pointer or a primitive ([pointers and primitives](#data_vs_pointers)).
Loads and stores take a pointer as base, add the instruction's offset to the pointer's index and check the result against the bounds of the object.
Arithmetic on a pointer and a primitive modifies only the index, so its result is again a pointer to the same object. Subtracting two pointers to the same object yields their distance as a primitive.
Operations which would mix up different objects, like subtracting or ordering pointers to two different objects, raise an *IncompatibleTypeException*.
A pointer occupies exactly one XLEN-wide element in memory. It can be loaded and stored as a whole, but never in parts, so its bytes can be neither read nor partially overwritten ([RISC-V I vs I'](#riscv_i_tick)).
In the following example, `obj.36` denotes a pointer to the object `obj` with index 36:

```asm
    alci    a0, 40          ;# a0 = obj.0: pointer to a new, zeroed object of 40 bytes
    addi    a1, a0, 36      ;# a1 = obj.36: still a pointer to the same object
    sw      zero, 0(a1)     ;# accesses bytes 36 to 39: inside the object
    sw      zero, 4(a1)     ;# would access byte 40: IndexOutBoundsException
    sub     a2, a1, a0      ;# a2 = 36: the distance of two pointers is a primitive
```

**Memory management.** No instruction frees an object. The memory of an object is reclaimed by a garbage collector once no pointer to the object is left,
so neither use-after-free nor double free can occur, and memory a program forgot to release is reclaimed as well.
Since the hardware identifies every pointer, garbage collection is exact, and the collector may move objects to compact the heap, as it is able to update every pointer to them.
Whether the collector is implemented in privileged software or in hardware is left to the implementation. For C programs, *malloc* is realized using *alc*, and *free* has nothing left to do.

**Frames.** The stack is replaced by a linked list of frame objects. A function's prologue allocates its frame with *alc* or *alci* into *sp*, which stores the previous *sp* at index 0 of the new frame. *ra* is saved in a reserved slot right behind it ([structure](#are_obj)).
Frame objects are accessible through *sp* only, *sp* cannot be copied into another register, and colours held by *sp* and *ra* let the processor recognise whether the current function owns the current frame. Accessing another function's frame raises a *StateException* ([frame ownership](#frame_ownership)).
*ret* clears *ra*, so a return address can be used only once. Since no function can access its caller's frame, arguments are never passed on the stack: arguments not fitting into *a0* to *a6* are passed in an argument object referenced by *a7* ([calling convention](#chap_calling_convention)).

**Code.** Instructions are held in executable objects, which can be executed but never read or written, and data can never be executed ([object tags](#isa_tags)).
*auipc*, *jal* and *jalr* produce pointers into executable objects, and an indirect jump through a pointer requires it to reference an executable object.
Everything outside a program's own code, from global variables and string literals to functions in shared libraries, is reached through the program's global offset table.
Every executable object holds a pointer to this table in its GOT slot at index 0, in front of its first instruction. Code running in an executable object can load this pointer, by convention into *gp*, but no code can load the GOT slot of any other executable object, so a pointer to a function never gives access to the globals of its program ([global offset table](#got)).

**System management software.** A small set of privileged instructions allows machine and supervisor mode software to create pointers to objects and I/O devices (*dtp*), inspect them (*sep*, *btd*, *itd*), read and change the tags of objects (*lt*, *st*) and clear memory for reuse (*clr*) ([privileged instructions](#priv_instructions)).
Loaders, garbage collectors and device drivers are built on these instructions. User mode code has no access to them, which is what makes the guarantees below hold.

### Guarantees {#guarantees}

RISC-ViO gives every user mode program the following guarantees:

1. **Spatial safety.** Every load, store and jump through a pointer is checked against the bounds of the referenced object before it takes effect.
2. **Pointer integrity.** User code cannot create a pointer from a primitive, cannot change which object a pointer references and cannot assemble a pointer from parts of other values.
3. **Temporal safety.** The memory of an object is reused only once the object has become unreachable, so no pointer ever references memory that has been reused for another object.
4. **Separation of code and data.** The instructions held in executable objects can neither be read nor written by any instruction, and no instruction is ever fetched from an object that is not executable. The only element of an executable object that can be loaded at all, its GOT slot, can be loaded only by code running in that executable object.
5. **Frame and return integrity.** A function can access only the frame it allocated itself, and a return address can only be produced by a call and consumed once by a return.
6. **No uninitialised memory.** A newly allocated object holds nothing but the primitive value 0.

Guarantees 1, 2, 4, 5 and 6 follow from the rules of this specification alone. Guarantee 3 additionally depends on a correct garbage collector, be it implemented in software or in hardware.
All guarantees assume that the system management software uses its privileged instructions correctly.
Indirect jumps are confined to executable objects. Restricting them further to function entries is left to the landing pads of Zicfilp, which RISC-ViO can be combined with.

The following properties are deliberately not guaranteed in this version:

- Bounds are checked per object. An overflow from one field of a struct into the next field of the same struct is not detected.
- Memory that remains reachable stays allocated, even if the program never uses it again. Garbage collection removes unreachable memory, not unused memory.
- System management software is trusted. It can create arbitrary pointers and change the tags of any object.

## Trade-offs {#tradeoffs}

Memory safety does not come for free, on RISC-ViO either. Each design goal involves a deliberate trade-off, and this section gives a short overview of them.

**Objects as the unit of protection.** Keeping bounds and permissions once per object instead of in every pointer is what keeps pointers XLEN wide and makes revocation unnecessary.
Accordingly, protection reaches down to objects: an overflow between two fields of the same struct stays undetected, and a read-only view of a writable object is expressed by a separate object.

**Recompilation instead of binary compatibility.** RISC-ViO has no unprotected mode, so every program runs with the full set of guarantees. In turn, existing RISC-V binaries have to be recompiled.
The toolchain, the C library and the system management software are adapted once. Application code is recompiled and needs changes only where it treats pointers as raw integers, for example by reading the bytes of a pointer or by constructing pointers from integers, just as on CHERI.
Formally, I' is a modified base ISA rather than an extension, which is the same route CHERI takes with RVY.

<!-- FIXME: quantify the porting effort on real code bases (e.g. changed lines per package) and cite it here. -->

**Garbage collection.** Temporal safety by construction requires a garbage collector, whose cost depends on its design. RISC-ViO leaves this choice to the implementation, from a stop-the-world collector in software to a concurrent collector in hardware with real-time properties.
Allocating a frame object for every call raises the allocation rate, a pattern that copying collectors are known to handle well[^appel]. Memory remains allocated as long as it is reachable.

**Hardware.** Every register holds the metadata needed to check accesses along with its pointer, and every memory element records whether it holds a pointer.
The example implementation achieves this without changes to the memory system, with an additional pipeline stage and an encoding that needs an additional memory access for some values.
Even accesses to a program's own global data go through the global offset table, whose pointer every function needing it first loads from its executable object, and again after every call that may leave this object.
How RISC-ViO's net performance compares to *malloc* and *free* combined with today's mitigations is a matter of evaluation, and this specification does not state performance figures.

<!-- FIXME: add measured results (or a reference to the evaluation) as soon as they are available. -->

## Comparison {#related}

The table summarises how RISC-ViO relates to the approaches discussed in the [motivation](#motivation).

|                         | RISC-ViO                                                 | CHERI (RVY)                                        | Memory tagging (MTE)                 | O-RISC                                        |
| :---------------------- | :------------------------------------------------------- | :------------------------------------------------- | :----------------------------------- | :-------------------------------------------- |
| Protection attached to  | the object                                               | the pointer                                        | memory granule and pointer           | the object, rights per pointer                |
| Pointer identification  | per register and element, encoding up to implementation  | tag bit per capability, throughout memory system   | none                                 | separation: own register file and index space |
| Unforgeable pointers    | yes                                                      | yes                                                | no                                   | yes                                           |
| Pointer width in memory | XLEN                                                     | 2·XLEN                                             | XLEN                                 | not visible to software                       |
| Spatial safety          | deterministic, per object                                | deterministic, per capability, sub-object possible | probabilistic, per 16-byte granule   | deterministic, per object                     |
| Temporal safety         | no *free*, exact garbage collection                      | revocation of freed memory                         | probabilistic, by retagging          | no *free*, garbage collection                 |
| Pointer arithmetic      | on the index, any distance                               | on the address, within the representable range     | unrestricted                         | none                                          |
| C and C++               | largely source compatible                                | largely source compatible                          | binary compatible                    | excluded by design                            |
| Unmodified binaries     | no                                                       | optionally, unprotected (hybrid mode)              | yes                                  | no                                            |
| Base ISA                | RISC-V, modified base (I') and zhm                       | RISC-V, new bases (RVY)                            | Arm extension, RISC-V in development | own ISA, influenced by RISC-V                 |

Compared to memory tagging, RISC-ViO trades binary compatibility for deterministic protection and unforgeable pointers.
Compared to CHERI, it trades sub-object bounds, permissions per pointer and a mode for unmodified code for XLEN-wide pointers, unchanged data layouts, a memory system without tags and temporal safety without revocation.
Compared to O-RISC, which inspired it, it trades the structural separation of pointers and data for C's pointer model and the RISC-V base.

## About this specification {#about}

**Status.** This document is a draft. Parts of the architecture are still under discussion, and the topics listed as not yet covered below will be added in later versions.

**Structure.** As the legend at the beginning states, this document consists of two kinds of chapters.
[*ISA*]{.isa} chapters define the architecture: what every RISC-ViO processor has to do and what software can rely on. They are normative.
[*Implementation*]{.imp} chapters describe one possible implementation, an in-order pipeline with an additional attribute stage. They are informative: an implementation may realize the ISA differently, as long as its behaviour matches the ISA chapters.

- [The object based memory model](#base_spec): objects, tags, pointers and primitives, and the changes to the RISC-V base ISA
- [The zhm extension](#instructions): allocation, attribute queries and the privileged instructions
- [The not so stacked frames](#frames): frame objects, the calling convention and frame ownership
- [Global offset table](#got): how programs reach their data and other code, and how they are loaded
- [Exceptions](#exceptions): the exceptions RISC-ViO adds and the registers restricted in user mode
- [Register file](#reg_fl), [objects in memory](#hard_obj) and [pointer and address generation](#ptr_addr): the example implementation
- [Tables](#tables) and [appendix](#appendix): encodings, exception codes, CSRs, boot process, supervisor services and glossary

**Scope.** This version specifies RV32I and RV64I in their modified form I' together with the zhm extension, for user, supervisor and machine mode.
Not yet covered are the interaction of pointers with the standard extensions (in particular M, A, F, D, C, V and Zicfilp), multiple harts and memory ordering, thread-local storage, *setjmp*/*longjmp* and virtual memory.

**Notation.** XLEN is the register width. A pointer is written as x.y, where x denotes the referenced object (or its base address) and y the index.
In figures, pointers are drawn in shades of pink and purple, primitives in light blue. All terms are defined in the [glossary](#abbrevs_gloss).

# The object based memory model {#base_spec}

In RISC-ViO, objects are leveraged as the way to achieve the design goals outlined in the motivational chapter.
In order to enforce the correct use of these objects and references to these objects, RISC-ViO alters the semantics of some of the instructions which are part of the RISC-V I base instruction set.
This alteration of the RISC-V base ISA is denoted as the RISC-V I' ISA.

## Objects and I/O devices {#objects_devices}

Objects are unique, bounded areas allocated in memory.
The defining traits of such objects are their XLEN-wide length as well as their tags.
These tags determine both the kind of an object and the accesses permitted on it, as described in the [object tags](#isa_tags) section.
The tags of an object may only be altered using special, privileged instructions.

::: figure
![Visualization of a pointer (pink), primitive (blue) and an object](svg/software_objects/object1.svg)

Visualization of a pointer (pink), primitive (blue) and an object
:::

I/O devices behave similarly to objects in that they also have an XLEN-wide length as well as XLEN-wide tags.
In contrast to objects, the length of an I/O device is fixed by the hardware and cannot be influenced by software.
For consistency, the tags of I/O devices are encoded the same way as the tags of objects.
They are undefined after reset and have to be set up correctly by the system management software using the [st](#st) instruction.
I/O devices are uniquely identified by their device number.

<!-- OPEN FOR DEBATE: drop the separate I/O pointer kind and model devices as data only objects at their memory-mapped
     addresses, referenced by ordinary pointers created with dtp. This would remove the 'io' kind bit, device numbers
     and bit 0 of the reference word. Device objects lie outside the heap and hold no pointers, so the garbage collector
     never moves, scans or reclaims them, and data only objects already reject stores of pointers.
     Open: an implementation keeping headers in memory cannot place one in front of a device, so the length and tags of
     device objects have to come from elsewhere, e.g. from a table selected by address range. -->

::: figure
![Ordinary, executable and data-only objects](svg/software_objects/object2.svg)

Ordinary, executable and data-only objects
:::

## Object tags {#isa_tags}

::: encoding
| implementation specific | scratch | weak | permissions || kind ||||
| XLEN-1:23               | 22:7    | 6    | 5           | 4   | 3    | 2         | 1          | 0        |
| :---------------------: | :-----: | :--: | :---------: | :-: | :--: | :-------: | :--------: | :------: |
| ...                     | ...     | i    | r           | w   | io   | data only | executable | ordinary |
:::

The tags of an object or I/O device are represented by an XLEN-wide word which can be read and written by the system management software using the privileged [lt](#lt) and [st](#st) instructions.
They are made up of the kind bits, the permission bits, the weak bit, sixteen scratch bits and the implementation specific bits.

The kind bits determine what an object may be used for. Exactly one of them is set for every object or I/O device.

Objects having their 'ordinary' bit set are denoted as ordinary objects.
Such objects may hold any data meaning both primitives and pointers may be stored in an object of this kind.
In order to enforce the separation of instructions and data however, instructions may not be fetched from such objects and executed afterwards.

Objects having their 'data only' bit set are said to be data only objects.
Data only objects, unlike ordinary objects, may not contain pointers.
Just as with ordinary objects, it is not allowed to fetch and execute instructions from such objects.
By keeping pointers out of data only objects, it is possible to achieve an improvement of memory access efficiency in some implementations.
Another advantage of objects not containing any pointers is the reduction of the effort caused by garbage collecting these objects.

Objects having their 'executable' bit set contain instructions.
The first XLEN/8 bytes of an executable object, index 0 up to XLEN/8 − 1, form its *GOT slot*. It holds a pointer to the global offset table of the program the object belongs to, or the primitive value 0 if there is none ([global pointer](#gp)). The instructions follow from index XLEN/8 on.
System management software building an executable object as an ordinary or data only object uses the same layout, so indices into its code stay the same when it is retyped.
Apart from loading the GOT slot as described in the [global pointer](#gp) section, no instruction may explicitly access the contents of an object of this kind. Only the processor may implicitly read from executable objects to fetch instructions.
This makes it necessary for system management software to load in code in the form of a data only object and then alter its kind using the *st* instruction.

The 'io' bit marks the tags as belonging to an I/O device as described in the [objects and I/O devices](#objects_devices) section.

The permission bits 'r' and 'w' state whether an object or I/O device may be read or written using load and store instructions.
Both may be set or cleared in any combination, except for executable objects, which always have both permission bits cleared, and data only objects, which always have at least one of them set, since a data only object which can be neither read nor written has no use.

Objects having their 'i' bit set are called *weak cells*. The 'i' bit may only be set for ordinary objects.
Pointers held in a weak cell do not keep the objects they reference alive: the garbage collector does not consider them when determining which objects are reachable.
Once an object referenced from a weak cell has been collected, every pointer to it held in a weak cell is replaced by the primitive value 0, at the latest at the end of the collection cycle and in any case before the memory of the object is reused.
A program therefore only ever loads a valid pointer or the primitive value 0 from a weak cell, the latter comparing equal to *zero* just like a null pointer in C.
A pointer loaded from a weak cell into a register is an ordinary pointer and keeps its object alive like any other.
All pointers held in a weak cell are weak. A runtime building a weak reference with further fields, like a reference queue, keeps these fields in an ordinary object pointing to a weak cell.
Since the 'i' bit can only be set using *st*, user code obtains weak cells from the system management software ([supervisor services](#services)).

<!-- FIXME: not covered yet:
     * ephemerons (a value kept alive only as long as its key is)
     * notification about cleared weak pointers (reference queues, finalization)
     * pointers with a non-zero index in weak cells, which the example implementation displaces into sanctuary objects
       (see the FIXME in the sanctuaries section) -->

The sixteen scratch bits are not interpreted by the hardware and may be used freely by the system management software, e.g. for the identity numbers of the [identity number service](#services).
When the garbage collector moves an object, its tags, including the scratch bits, move along with it.
All bits above the scratch bits are implementation specific. Some of them may for example be reserved by a hardware garbage collector.
Note that information only required by an implementation, like whether an object is a frame object, is not part of the tags on ISA level.

## Pointers and primitives {#data_vs_pointers}

The RISC-V I' ISA differentiates between two data kinds in the register file and in memory: references to objects or I/O devices, called pointers, and regular data, being denoted as primitives.

Pointers have a total of two separate fields. One of those is a reference field containing either an objects base address or the number of an I/O device.\
A pointers second field always contains an index which may point to any byte of the referenced object or I/O device.
The pointer encoding has to allow pointers to cover the entire address space of the processor of XLEN bits.

A primitive like a number or a character may be arbitrarily modified just as it is possible in RISC-V.

For a pointer, in contrast, some restrictions apply regarding the way in which it may be modified.
Arithmetic or logic operations on a pointer and a primitive like additions or bitwise inversions modify the pointer as a regular address would have been modified by the executed operation.
This modification is achieved by only altering a pointers index field while the reference field stays unchanged. The result of such an operation therefore is a pointer again.
Note that pointers having an index reaching out of the bounds of an object or I/O device are allowed in both the register file and in memory.\
Operations on two pointers are restricted to subtraction (*sub*) as well as the logic operations *and*, *or* and *xor*. They are only allowed in the case that both pointers reference the same object or I/O device.
Such an operation acts only on the indices of both pointers and its result is a primitive. Any other arithmetic operation on two pointers, like an addition or a shift, leads to an *IncompatibleTypeException*.
The same restriction applies to ordered comparisons of two pointers: they act only on the indices of both pointers and are only allowed if both pointers reference the same object or I/O device.
Trying to execute any of these operations on two pointers referencing different objects or I/O devices leads to an *IncompatibleTypeException*.
To check whether two pointers reference the same object, the [bso](#bso) instruction is provided.\
Ordered comparisons of a pointer with a primitive are not allowed either and lead to an *IncompatibleTypeException*.
Equality comparisons (*beq*, *bne*), in contrast, are always allowed. Two pointers are equal if they reference the same object or I/O device with the same index.
A pointer and a primitive are never equal. Thus, comparing a pointer with the *zero* register always yields 'not equal', which matches the semantics of a null pointer check in C.
Note that *seqz* and *snez* are realized using *sltiu*/*sltu* in RISC-V and are therefore ordered comparisons, which may not be used on pointers.
In order to write the result of an equality comparison into a register nonetheless, a branch using *beq* or *bne* has to be used:

```asm
    li    a0, 0
    bne   a1, a2, 1f      # works for any combination of pointers and primitives
    li    a0, 1
1:
```

<!-- OPEN FOR DEBATE: dedicated seq/sne instructions in zhm would turn this sequence into a single instruction.
     They are seen as an optimization rather than a necessity, so the branch is used for now. -->

::::::

:::::: imp

## Pointer Arithmetics {#imp_ptr_idx}

::: figure
![Composition of a pointer](svg/software_objects/pointer_plus_index.svg)

Composition of a pointer
:::

::: figure
![Primitive plus primitive](svg/software_objects/prim_plus_prim.svg)
![Pointer plus primitive](svg/software_objects/pointer_plus_prim.svg)
<!-- FIXME: the pointer plus pointer figures still show the old base address selection rule.
     Pointer plus pointer now yields a primitive for the same object and an exception otherwise. -->
![Pointer plus pointer, first case](svg/software_objects/pointer_plus_pointer_1.svg)
![Pointer plus pointer, second case](svg/software_objects/pointer_plus_pointer_2.svg)

Different forms of arithmetics depending on the input types
:::

::::::

:::::: isa

## RISC-V I vs I' {#riscv_i_tick}

For the differentiation between pointers and primitives to be meaningful, RISC-ViO mandates that only pointers may be used to access memory via the object abstraction. The same is also true for accesses to I/O devices: Accesses to I/O devices are only possible via their corresponding pointers.
(Note that I/O devices only accept primitives. Pointers may not be written to I/O devices.)
This requirement influences all load and store instructions as listed below:

::: inline
- lb/lbu
- lh/lhu
- lw
- lwu (RV64)
- ld (RV64)
- sb
- sh
- sw
- sd (RV64)
:::

The main change for those instruction families lies in them requiring pointers to be used to select objects and I/O devices instead of memory locations.
Offsets from those pointers using the 12 bit immediate present in those instructions are still allowed.
Those offsets are added to the index of the pointer used to access the object to make up the offset used for the actual object or I/O device access.
Being explicit memory accesses in the case of pointers of memory kind, these instructions may only access ordinary as well as data only objects.
Pointers always occupy a whole XLEN wide, aligned element of an object.
Loading only part of an element holding a pointer using a narrower load (*lb*, *lbu*, *lh*, *lhu* as well as *lw*, *lwu* on RV64) leads to an *IncompatibleTypeException*.
A narrower store (*sb*, *sh* as well as *sw* on RV64) into an element holding a pointer first clears the whole element and then writes the stored bytes, overwriting the pointer.
XLEN wide loads and stores (*lw*/*sw* on RV32, *ld*/*sd* on RV64) work on elements holding pointers and primitives alike.
Whenever one of these rules is broken, the processor raises a hardware exception. Which exception is raised in which case is listed in the [exceptions](#exceptions) chapter.

<!-- FIXME (@Leyla): create a figure showing a load/store via pointer, index and offset -->

Since instructions are managed using executable objects, the semantics of even more instructions have to be altered:

::: inline
- auipc
- jalr
- jal
:::

The *auipc* instruction for example will emit a pointer instead of a primitive value.
Due to the access to executable objects being limited as described in the [object tags](#isa_tags) section however, access to constant data is not possible using this pointer. The only element that can be loaded through it is the GOT slot of the current executable object ([global pointer](#gp)).

The encapsulation of instructions also alters the semantics of *jalr*. Depending on the content of its source register, *jalr* behaves in one of two ways:
If the source register contains a pointer, this pointer has to reference an executable object. The program counter is then set to this pointer, with the immediate being added to its index.
For the separation of data and instructions, using a pointer to any other kind of object as jump target leads to an *IncompatibleTypeException*.
If the source register contains a primitive, *jalr* jumps to the index given by this primitive and the immediate inside the currently executed executable object.
In both cases, *jalr* will also, just as *jal* does, write a pointer to its destination register.

Instructions are only fetched from index XLEN/8 on, since the first XLEN/8 bytes of every executable object form its GOT slot ([object tags](#isa_tags)).
A jump or branch to an index below XLEN/8 or beyond the end of the executable object raises a *JumpIndexOutBoundsException*, and so does running past its end.
In particular, a jump through the primitive value 0, like `jalr t0, 0(zero)` or a call through a null function pointer, raises a *JumpIndexOutBoundsException*.

<!-- OPEN FOR DEBATE: jalr with a primitive source jumps to any index of the current executable object. Since overflows
     inside an object are not detected and a narrow store into a pointer element turns it into a primitive, a corrupted
     function pointer field becomes a jump to an arbitrary index of the current code.
     No code needs this variant for correctness: every jump target is derived from auipc, from the link register written
     by jal/jalr or from a pointer stored by the loader, and arithmetic with primitives keeps it a pointer. A primitive
     target only arises from casting an integer to a function pointer, from calling a null function pointer or from
     corruption.
     Counter-argument: return addresses have to be cheap to save (design goal 6). This cost does not depend on the
     variant, since jal and jalr write pointers either way (see the FIXME in loading and storing a pointer). Making
     return addresses primitives would need primitive links and primitive jumps through ra, but breaks on tail calls
     into another executable object: the callee would return through a primitive meant for the executable object of
     the caller's caller. Primitive jumps through ra only (ra is restricted, so its primitives cannot be forged) would
     keep the protection for all other registers. -->

To make sure that a return address cannot be used twice, RISC-ViO mandates that the variant of *jalr* which realizes the *ret* pseudoinstruction has to null out the register *ra* except for its state tracking residue required for [frame ownership](#frame_ownership) after updating the program counter.

*lui* is not changed: just as in RISC-V, it always writes a primitive to rd, regardless of what rd held before.
Indices and offsets which do not fit into a 12 bit immediate are therefore built as a primitive and added to the pointer, which only changes its index:

```asm
    lui     t0, %hi(offset)
    add     t0, a0, t0          # a0 = obj.x  ->  t0 = obj.(x + %hi(offset))
    lw      a1, %lo(offset)(t0) # accesses index x + offset of obj
```

## Register file {#register_file}

The RISC-V ISA specifies 31 general-purpose registers and one special register, *zero*.
The RISC-ViO architecture adds additional requirements to this register file definition:

- each register has to be able to hold either a primitive of width XLEN or a pointer with a XLEN wide index.
- both *ra* and *sp* have to be able to hold colour information. (see [frames](#frames) chapter)

::: note
Note: The *zero* register has to contain the primitive value 0.
:::

# The zhm extension {#instructions}

In addition to the modifications of already existing instructions which are part of the RISC-V I base ISA, RISC-ViO introduces several instructions as an interface between software and hardware regarding objects.
Those instructions are all part of the zhm ("heap management") extension.

## Unprivileged instructions {#unpriv_instructions}

### Allocation: alc/alci/alc.d/alci.d {#alc_fam}

Since RISC-ViO manages objects on the ISA level, the ISA has to provide a means to create new objects and their corresponding pointers.
The creation of ISA level objects on the heap is achieved by the alc-instruction family which comes in four flavours.
In fact the alc instruction family is the only way to create new objects in user mode.
The next section provides a short description of those instructions alongside their bit encodings.
The objects allocated by the alc-instruction family are both readable and writable but not executable on allocation (their 'read' and 'write' bits are set).
Newly allocated objects only contain the primitive value 0.

In order for the system management software to influence where new objects are placed, the zhm extension introduces an additional machine mode CSR.
The CSR *malc* contains both the current allocation address, being the address of the object last allocated, as well as the heap limit, being the lowest address still part of the heap.
Those values are represented using a pointer, where the base address field contains the current allocation address and the index field contains the heap limit.
The CSR index of the *malc* CSR can be extracted from the [CSR table](#t_csr).

#### alc-instruction {#alc}

The *alc* instruction is the most basic form in its family. This instruction allows the allocation of an ordinary object where the size of the object is given by the value passed via rs2.
The size is given in bytes as per the value in rs2. Since objects are XLEN/8 byte granular, the size is rounded up to the next multiple of XLEN/8.

::: encoding
| 31:25   | 24:20     | 19:15 | 14:12 | 11:7     | 6:0     | Instruction |
| :-----: | :-------: | :---: | :---: | :------: | :-----: | :---------: |
| 0000000 | rs2 (src) | 00010 | 000   | rd (dst) | 0001011 | alc         |
:::

Assembly syntax: `alc rd, rs2` (rs2 holds the size in bytes)

When the *alc* instruction is used to allocate a frame by specifying *sp* as the destination register, its semantic is extended. In this case *alc* not only allocates a new frame object but also stores the old *sp* at index zero of the new frame object, making it the only field in the frame object which is not of primitive 0 value.

Note that the rs1 field of *alc* and *alci* is fixed to *sp* (00010).
Regardless of the destination register and regardless of what is actually encoded in this field, the decoder always reads *sp* via rs1 for these instructions, as the old *sp* has to be available in case a new frame object is allocated.
Since *alc.d* and *alci.d* may not allocate frame objects, this field is fixed to *zero* (00000) for them.

The alc instruction may trigger the following exceptions for the given events (xtval content):

- *HeapOverflowException*: Allocating the specified object would overflow the heap. (object_size as primitive)
- *IncompatibleTypeException*: rs2 contains a pointer, not a primitive (rs2)
- *ForbiddenDstException*: rd is ra (see [restricted registers](#restricted_regs)) (-)

#### alci-instruction {#alci}

The *alci* instruction is a variation of the *alc* instruction. In contrast to *alc*, the size of the new object is given by the 12 bit wide immediate.
This immediate specifies the amount of pointers which can fit inside the object, meaning it is scaled by XLEN/8.
So for a XLEN of 32, it specifies the number of 32 bit words that fit into the object and is encoded as imm[13:2].
For a XLEN of 64, it specifies the number of 64 bit double words that fit into the object and is encoded as imm[14:3].
In assembly, the immediate is written as the size of the object in bytes (e.g. `alci a0, 16`), which has to be a multiple of XLEN/8. The assembler then encodes this size divided by XLEN/8.

::: encoding
| 31:25     | 24:20 | 19:15 | 14:12 | 11:7     | 6:0     | Instruction |
| :-------: | :---: | :---: | :---: | :------: | :-----: | :---------: |
| imm[13:2] / imm[14:3] || 00010 | 010   | rd (dst) | 0001011 | alci        |
:::

Assembly syntax: `alci rd, size` (size in bytes, a multiple of XLEN/8)

Please note that the *alci* instruction behaves the same way *alc* does when rd is *sp*.

The *alci* instruction may trigger the following exceptions for the given events (xtval content):

- *HeapOverflowException*: Allocating the specified object would overflow the heap. (object_size as primitive)
- *ForbiddenDstException*: rd is ra (see [restricted registers](#restricted_regs)) (-)

#### alc.d-instruction {#alcd}

The *alc.d* instruction is a specialization of the *alc* instruction, allowing for the allocation of data only objects.
Note that it is also forbidden to use *alc.d* to allocate a new frame object.

::: encoding
| 31:25   | 24:20     | 19:15 | 14:12 | 11:7     | 6:0     | Instruction |
| :-----: | :-------: | :---: | :---: | :------: | :-----: | :---------: |
| 0000000 | rs2 (src) | 00000 | 001   | rd (dst) | 0001011 | alc.d       |
:::

Assembly syntax: `alc.d rd, rs2`

The *alc.d* instruction may trigger the following exceptions for the given events (xtval content):

- *HeapOverflowException*: Allocating the specified object would overflow the heap. (object_size as primitive)
- *IncompatibleTypeException*: rs2 contains a pointer, not a primitive (rs2)
- *ForbiddenDstException*: rd is sp or ra (see [restricted registers](#restricted_regs)) (-)

#### alci.d-instruction {#alcid}

The *alci.d* instruction is the analogous form of *alci* regarding data only objects. It differs in the kind of allocated object and in that it also is prohibited from allocating frames.

::: encoding
| 31:25     | 24:20 | 19:15 | 14:12 | 11:7     | 6:0     | Instruction |
| :-------: | :---: | :---: | :---: | :------: | :-----: | :---------: |
| imm[13:2] / imm[14:3] || 00000 | 011   | rd (dst) | 0001011 | alci.d      |
:::

Assembly syntax: `alci.d rd, size`

The *alci.d* instruction may trigger the following exceptions for the given events (xtval content):

- *HeapOverflowException*: Allocating the specified object would overflow the heap. (object_size as primitive)
- *ForbiddenDstException*: rd is sp or ra (see [restricted registers](#restricted_regs)) (-)

### Attribute query: qsz {#qsz}

The *qsz* instruction provides a means of reading an objects size in bytes as specified at its allocation time. For this, the source register has to contain a pointer.
Since object sizes are rounded up to multiples of XLEN/8 on allocation, the size returned by *qsz* is always a multiple of XLEN/8 as well.

::: encoding
| 31:25   | 24:20 | 19:15     | 14:12 | 11:7     | 6:0     | Instruction |
| :-----: | :---: | :-------: | :---: | :------: | :-----: | :---------: |
| 0000000 | 00000 | rs1 (src) | 100   | rd (dst) | 0001011 | qsz         |
:::

Assembly syntax: `qsz rd, rs1`

The *qsz* instruction may trigger the following exceptions for the given events (xtval content):

- *IncompatibleTypeException*: rs1 contains a primitive, not a pointer (rs1)
- *ForbiddenDstException*: rd is sp or ra (see [restricted registers](#restricted_regs)) (-)

### Check object identity: bso {#bso}

Since ordered comparisons of two pointers referencing different objects are forbidden, the *bso* instruction provides a way to check whether two pointers reference the same object, e.g. for *memmove* to decide whether two buffers may overlap.
*bso* takes two pointers in rs1 and rs2 and, if they reference the same object, adds the displacement immediate to the index of the program counter, just as *beq* does. Otherwise, it does nothing.
There is no instruction writing the result of this check to a register. As for equality comparisons, a branch is used for this (see [pointers and primitives](#data_vs_pointers)).

::: encoding
| 31:25   | 24:20 | 19:15     | 14:12 | 11:7     | 6:0     | Instruction |
| :-----: | :---: | :-------: | :---: | :------: | :-----: | :---------: |
| imm[12\|10:5]  | rs2 (src)| rs1 (src) | 111   | imm[4:1\|11]  | 0001011 | bso         |
:::

Assembly syntax: `bso rs1, rs2, offset`

The *bso* instruction may trigger the following exceptions for the given events (xtval content):

- *IncompatibleTypeException*: rs1 or rs2 contain a primitive, not a pointer (rs1 or rs2)

<!-- OPEN FOR DEBATE: since a null pointer is the primitive value 0 and beq/bne never trap on mixed operands, bso could
     simply not branch if either operand is a primitive. Code like memmove would then not need a null check in front. -->

## Privileged Instructions {#priv_instructions}

With the instructions described above, it is impossible to break out of the restrictions given by the bounds check and pointer integrity safety measures. It is also not possible to influence object behaviour regarding permissions.
To enable the management of the processor system, which requires low level control over these features, additional instructions are available for all privilege modes above the user mode.

### Raw pointer access: sep/btd/itd/dtp {#raw_ptr_access}

In order to be able to create and inspect pointers a total of four instructions are provided. These allow for asserting that a register contains a pointer, reading out the integral parts of a pointer as well as creating arbitrary pointers.

*btd* and *dtp* exchange the reference field of a pointer in the form of a primitive called *reference word*, which also tells pointers to objects and pointers to I/O devices apart:

::: encoding
| reference word                          ||
| XLEN-1:1                                | 0     |
| :-------------------------------------: | :---: |
| base address[XLEN-1:1] or device number | io    |
:::

For a pointer to an object, the reference word is the base address of the object. Implementations place objects at even base addresses, so bit 0 is always 0.
For a pointer to an I/O device, the reference word holds the device number in bits XLEN-1:1 and has bit 0 set.
Passing the results of *btd* and *itd* to *dtp* therefore always rebuilds the original pointer, regardless of what it references.
How an implementation represents the reference field internally is not visible to software.

#### sep-instruction {#sep}

The *sep* 'set if pointer' instruction allows for checking for the kind of value present in a register. When the register given by rs1 contains a primitive, a primitive of value 0 is written into the register given by rd.
Otherwise, a non 0 primitive value is written to this register.

::: encoding
| 31:25   | 24:20 | 19:15    | 14:12 | 11:7    | 6:0     | Instruction |
| :-----: | :---: | :------: | :---: | :-----: | :-----: | :---------: |
| 1111110 | 00000 | rs1(ptr) | 000   | rd(tag) | 1110011 | sep         |
:::

Assembly syntax: `sep rd, rs1`

#### btd-instruction {#btd}

The btd 'base to data' instruction allows for reading out the reference field of a pointer. The reference word of the pointer given in rs1, i.e. the base address of the referenced object or the device number of the referenced I/O device with bit 0 set, is written into rd as a primitive.

::: encoding
| 31:25   | 24:20 | 19:15    | 14:12 | 11:7    | 6:0     | Instruction |
| :-----: | :---: | :------: | :---: | :-----: | :-----: | :---------: |
| 1101111 | 00000 | rs1(ptr) | 000   | rd(dst) | 1110011 | btd         |
:::

Assembly syntax: `btd rd, rs1`

The *btd* instruction may trigger the following exceptions for the given events (xtval content):

- *IncompatibleTypeException*: rs1 contains a primitive, not a pointer (rs1)

#### itd-instruction {#itd}

The *itd* 'index to data' instruction allows for reading out a pointers raw pointer index. This primitive value is written into rd for the pointer given in rs1.

::: encoding
| 31:25   | 24:20 | 19:15     | 14:12 | 11:7     | 6:0     | Instruction |
| :-----: | :---: | :-------: | :---: | :------: | :-----: | :---------: |
| 1011111 | 00000 | rs1 (ptr) | 000   | rd (dst) | 1110011 | itd         |
:::

Assembly syntax: `itd rd, rs1`

The *itd* instruction may trigger the following exceptions for the given events (xtval content):

- *IncompatibleTypeException*: rs1 contains a primitive, not a pointer (rs1)

#### dtp-instruction {#dtp}

The dtp 'data to pointer' instruction allows for the assembly of arbitrary pointers. The reference field is set according to the reference word in rs1, the index according to the value in rs2. The result is stored in rd.
If bit 0 of the reference word is set, the result is a pointer to the I/O device whose number is given by bits XLEN-1:1. This way, *dtp* is also used to link a pre-existing, memory-mapped I/O device to a pointer.
The *st* instruction is then used to set the tags of this I/O device such that they represent how the I/O device may be used (see [objects and I/O devices](#objects_devices)).

::: encoding
| 31:25   | 24:20    | 19:15      | 14:12 | 11:7     | 6:0     | Instruction |
| :-----: | :------: | :--------: | :---: | :------: | :-----: | :---------: |
| 0111111 | rs2 (ix) | rs1 (ref) | 000   | rd (dst) | 1110011 | dtp         |
:::

Assembly syntax: `dtp rd, rs1, rs2` (rs1 holds the reference word, rs2 the index)

The *dtp* instruction may trigger the following exceptions for the given events (xtval content):

1. *IncompatibleTypeException*: rs1 contains a pointer, not a primitive (rs1)
2. *IncompatibleTypeException*: rs2 contains a pointer, not a primitive (rs2)

### Object tag access: lt/st {#lt_st}

In order for a system software to gain control over the tags that make up an objects traits, additional instructions are required. Both read and write access to these tags is possible using the instructions introduced below.

#### lt-instruction {#lt}

The *lt* instruction enables reading out the tags of an object by placing the tags of the object or I/O device pointed to by the contents of rs1 into the register rd in the form of a primitive.
For information on how these tags are encoded, please refer to the discussion of [tags on ISA level](#isa_tags).
*lt* always returns the tags on ISA level. How an implementation represents them in memory is never visible to software.

::: encoding
| 31:25   | 24:20 | 19:15     | 14:12 | 11:7      | 6:0     | Instruction |
| :-----: | :---: | :-------: | :---: | :-------: | :-----: | :---------: |
| 1110111 | 00000 | rs1 (ptr) | 000   | rd (tags) | 1110011 | lt          |
:::

Assembly syntax: `lt rd, rs1`

The *lt* instruction may trigger the following exceptions for the given events (xtval content):

- *IncompatibleTypeException*: rs1 contains a primitive, not a pointer (rs1)

<!-- OPEN FOR DEBATE: make lt usable in user mode.
     Benefits: runtimes read identity numbers without an ecall, so the identity number service is only needed to assign
     one. The type query service becomes obsolete. Library functions like memcmp, memcpy or strlen can check whether an
     object is data only and then use byte loads freely, since such an object never holds a pointer.
     lt reveals no addresses, since the reference field stays hidden behind btd, and lt sp already raises a
     ForbiddenSrcException under the rules for restricted registers.
     Issues:
     * The implementation specific bits may hold state of a hardware garbage collector, like mark bits. User code could
       observe the progress of the collector or start depending on bits which differ between implementations, so
       user-mode lt should return them as 0.
     * Anything the system management software keeps in the scratch bits becomes readable. The field should then become
       an identity field with defined semantics, possibly leaving a few bits private to the system management software
       and masked in user mode.
     * The example implementation answers lt from the header copy in the register file. After an identity number has
       been assigned through one register, other registers holding a pointer to the same object still show 0, so user
       code has to treat 0 as 'unknown' and ask the system management software.
     * The encoding of lt lies among the privileged SYSTEM instructions. A user-mode query fits better next to qsz in
       custom-0 (e.g. funct3 100, funct7 0000001). st stays privileged.
     Option: making sep usable in user mode as well. Knowing whether a value is a pointer does not help to forge one,
     and memcmp could then handle ordinary objects itself, so the word compare service would become obsolete, too. -->

#### st-instruction {#st}

The *st* instruction is the companion of the *lt* instruction, allowing object or I/O device tags to be written. For this, *st* sets the tags of the object or I/O device being referenced by the content of the rs1 register to the tags provided in rs2 in form of a primitive.
*lt* and *st* are completely symmetric: the tags returned by *lt* can be passed to *st* unchanged and vice versa.

::: encoding
| 31:25   | 24:20    | 19:15     | 14:12 | 11:7  | 6:0     | Instruction |
| :-----: | :------: | :-------: | :---: | :---: | :-----: | :---------: |
| 1111011 | rs2 (sd) | rs1 (ptr) | 000   | 00000 | 1110011 | st          |
:::

Assembly syntax: `st rs1, rs2` (rs1 holds the pointer, rs2 the tags)

The *st* instruction may trigger the following exceptions for the given events (xtval content):

1. *IncompatibleTypeException*: rs1 contains a primitive, not a pointer (rs1)
2. *IncompatibleTypeException*: rs2 contains a pointer, not a primitive (rs2)

### Memory clearing: clr {#clr}

To enable garbage collection in software, it is necessary to be able to clear out certain memory regions.
This is a consequence of mandating that newly allocated objects may only contain the primitive value 0.
A garbage collector implemented in software is able to use the *clr* instruction to ensure that this requirement is met.
This is achieved by this instruction writing the primitive value 0 of XLEN width to the memory address given by the contents of register rs1.
This address has to be aligned accordingly.

::: encoding
| 31:25   | 24:20 | 19:15    | 14:12 | 11:7  | 6:0     | Instruction |
| :-----: | :---: | :------: | :---: | :---: | :-----: | :---------: |
| 1111101 | 00000 | rs1(addr) | 000   | 00000 | 1110011 | clr         |
:::

Assembly syntax: `clr rs1`

The *clr* instruction may trigger the following exceptions for the given events (xtval content):

1. *IncompatibleTypeException*: rs1 contains a pointer, not a primitive (rs1)
2. *Store/AMO address misaligned*: primitive in rs1 is not aligned

# The not so stacked frames {#frames}

In order to protect the local data as well as control flow data of a function, RISC-ViO alters the concept of what is called a stack in conventional architectures.
To protect the stand-ins for this stack, the so-called frame objects or frames, from malicious or accidental modification by foreign functions, RISC-ViO introduces additional protection mechanisms for these frame objects.

Apart from objects for ordinary data storage the I' ISA also manages the stack as a series of objects. This partition of the stack in a single frame per function allows for further security mechanisms but also requires cooperation by the program.
Most notably, the stack is not grown by arithmetically modifying the stack pointer. Instead, the program has to manually allocate a new frame object. Once this frame object has been allocated, accesses to inside this object behave just the way the stack frame in RISC-V behaves.\
Due to the stack pointer register now containing a pointer, I' is able to protect older frame objects from accesses by arithmetical modification of sp.
The implications for the passing of function arguments between functions are outlined in the [calling convention](#chap_calling_convention) chapter.

Since every newly allocated frame object holds a pointer to its predecessor at index zero, the frame objects of a program form a singly linked list.
In contrast to a conventional stack, these frame objects do not have to lie next to each other in memory. Instead, they are placed on the heap just like any other object.
Returning to the previous frame object is achieved by loading *sp* from this slot, which makes the current frame object unreachable and allows it to be removed by the garbage collector.

## Structure {#are_obj}

Frame objects are based on ordinary objects but differ in the accesses which are allowed on them.
Most notably, frame objects can only be accessed through *sp* as described in the [restricted registers](#restricted_regs) section.
Frame objects are never data only which means the 'data only' flag is cleared.
To protect both the stack pointer *sp* as well as the return index *ra*, in frame objects special slots are reserved. For the 'stack' pointer *sp*, the pointer to the previous frame object, the first slot of XLEN size at byte index zero is reserved.
This is immediately followed by the *ra* slot which is also XLEN wide. For XLEN=32, this slot resides at byte index 4, for XLEN=64 at byte index 8.
In user mode, these slots of a frame object are only allowed to be used to store or load their respective register. Any other operation on these slots will lead to a *ForbiddenDstException* or *ForbiddenSrcException*.
Note that it is not only prohibited to store any other register than *sp* and *ra* in those slots, but also to store these registers anywhere else when not in a privileged mode.
This also holds for functions which do not save *ra* at all: the *ra* slot may never be used for anything else, which is why compilers have to place other spill slots behind it. The same restriction also applies when loading these registers.
These restrictions are enforced using *ForbiddenDstException* and *ForbiddenSrcException*.

::: figure
![A frame object for XLEN=32](svg/objektbaukasten/frame_object.svg)

A frame object for XLEN=32
:::

All other slots are general purpose and access to them is not restricted in any way.

<!-- FIXME: setjmp/longjmp are not covered yet. User code cannot implement them, since it would have to copy ra
     out of its slot and write sp by hand. They need a supervisor service (or ISA support) that keeps the saved
     context in a protected object, otherwise a program could forge the saved return address. -->
<!-- FIXME: thread local storage (tp) is not covered yet. -->

## Calling convention {#chap_calling_convention}

As described in the introduction to this chapter, RISC-ViO denies foreign access to frame objects. As a consequence, the calling convention has to be modified slightly from the convention used by RISC-V.
Namely, it is not possible to pass function arguments on the stack. Instead, the following scheme is employed:

The registers *a0* to *a6* carry arguments, assigned just as in the conventional RISC-V calling convention (e.g. a 64 bit value takes a register pair for XLEN=32).
The register *a7* is never used as an argument register.
Arguments which would be passed on the stack in conventional RISC-V are stored in a so-called argument object instead.
The caller allocates this object using *alc*/*alci*, stores the remaining arguments at the offsets they would have had on the stack and passes a pointer to the argument object in *a7*.
Since arguments may be pointers, argument objects may not be data only. The callee loads its arguments through *a7*.
As nothing is ever passed on the stack, frame objects contain neither an outgoing argument area nor incoming arguments.

The variable arguments of variadic functions are packed into an object as well, using one XLEN wide slot per argument (2·XLEN aligned for 2·XLEN aligned types).
A pointer to this object is appended as the last fixed argument and is therefore passed in a register or in the argument object.

Return values and callee-saved registers follow the conventional RISC-V calling convention, with *ra* being saved in its slot at byte index XLEN/8 of the frame object.

The GOT pointer ([global pointer](#gp)) is neither preserved across calls nor passed between functions. A function needing it loads it from the GOT slot of its executable object.
At a call or tail call that may leave its executable object, and at the return of a function that may be called from another executable object, no register may hold a pointer into the GOT of the function. This includes registers whose value is no longer needed.
The simplest way to meet this rule is to load the GOT pointer into the very register which the following load from the GOT overwrites, as GOT calls do ([making calls](#library_calls)). A function which keeps the GOT pointer in a register for several accesses, by convention *gp*, clears this register in front of such calls and returns, and loads the GOT pointer again after a call if it still needs it.
This way, the GOT of a program never ends up in the registers of code from another executable object, be it a library the program calls or a caller of one of its functions.
Calls to functions known to be part of the same image may keep the GOT pointer, since the callee can load it anyway.

## Frame ownership {#frame_ownership}

To achieve protection of frames from foreign accesses RISC-ViO uses so-called colour tags for both the *sp* and the *ra* register.
By updating those colours at critical points such as function entries/exits and frame allocations, the processor always knows whether the frame pointed to by the
*sp* register is owned by the currently executed function.
This state is called "regular", while the current function not being the owner of the current frame is denoted as the "irregular" state.

For *sp* as well as for *ra*, there are two colours: black and white. Those colours are an integral part of those registers and cannot be read or modified separately from their registers.
Also, when storing/loading *ra* and *sp* using *sw/lw*, their colour is also stored/retrieved to/from their slots.
An overview of the transition between those colours is given in the [colour transitions figure](#fig-colour-transitions).
On every function entry, signified by a call instruction (*jal* or *jalr* with *ra* as destination register), the processor flips the colour of ra from white to black or vice versa. The same also happens when a function is exited using *jalr zero, ra, 0 (ret)*. For *sp*, this takes place on every frame allocation using the *alc/alci* instructions.
Whether the processor is currently in the regular state (light blue), is given by the equality of the colours of ra and sp.
If the colours of *sp* and *ra* both were black for example, the processor would be in the regular state, allowing access to the current frame.

::: {#fig-colour-transitions .figure}
![Colour transitions](svg/vio_stack_colors_transitions.drawio.svg)

Colour transitions
:::

The [state transitions figure](#fig-state-transitions) provides two sample program flows for which the colour and therefore state transitions are shown.
Part a) of this figure shows the behaviour of the colour mechanism during the execution of a correct stream of instructions while part b) highlights how this mechanism catches bad program behaviour.
In part b) the colour mechanism spots function b trying to access function a's frame, which leads to the processor raising a *StateException*.

::: {#fig-state-transitions .figure}
![Transitions during normal program flow](svg/vio_stack_colors.drawio.svg "a) Transitions during normal program flow")
![Transitions during abnormal program flow with exception](svg/vio_stack_colors_exception.drawio.svg "b) Transitions during abnormal program flow with exception")

State transitions two instruction streams
:::

# Global offset table {#got}

The use of executable objects rules out jumps to fixed addresses. Loading and storing data at fixed addresses is incompatible with the object approach as well, since an integral address is a primitive and not a pointer.
In conventional architectures, addresses which are unknown at compile time are resolved using Global Offset Tables (GOTs).
In RISC-ViO, the GOT becomes the only way for a program to reach anything outside of its own code: functions of other programs and libraries, but also its own data, constants and string literals.
As a consequence, RISC-ViO programs never contain absolute address relocations like *R_RISCV_HI20*/*R_RISCV_LO12*.
All code is position independent and is linked as a position independent executable (PIE).

## Global pointer {#gp}

The GOT of a program is an ordinary object of its own. Unlike conventional GOTs, its slots do not hold integral addresses but pointers.

Every executable object holds a pointer to the GOT of the program it belongs to in its GOT slot, the first XLEN/8 bytes of the object ([object tags](#isa_tags)).
This pointer always references index 0 of the GOT object. It is written by the system management software while building the executable object and, since executable objects cannot be written, never changes afterwards.

Code obtains the GOT pointer by loading the GOT slot of the executable object it is running in, through a pointer created using *auipc*.
By convention, the GOT pointer is held in *x3* (*gp*):

```asm
1:  auipc   gp, %pcrel_hi(__got_slot)
    lw      gp, %pcrel_lo(1b)(gp)       # ld on RV64
```

The linker defines the symbol *__got_slot* XLEN/8 bytes in front of the code segment, which is where the GOT slot lies once the code segment has been loaded into an executable object ([loading a program](#loading)).
The following examples show the resulting instructions for two functions of an executable object *code*:

```asm
# f starts at index 0x2a8
f:      auipc   gp, 0               # gp = code.0x2a8
        lw      gp, -0x2a8(gp)      # gp = got.0, the content of the GOT slot at index 0

# g starts at index 0x12a8, too far for the 12 bit offset alone
g:      auipc   gp, 0xfffff         # gp = code.0x2a8: the immediate is -1, i.e. 0x12a8 - 0x1000
        lw      gp, -0x2a8(gp)      # gp = got.0
```

<!-- TODO: introduce a dedicated instruction loading the GOT slot of the current executable object, e.g. 'lgp rd'
     (custom-0 opcode 0001011, funct3 101, rs1 = rs2 = 00000, the program counter being the implicit base). It would
     replace

         1:  auipc   rd, %pcrel_hi(__got_slot)
             lw      rd, %pcrel_lo(1b)(rd)

     by a single instruction, needs neither the __got_slot symbol nor a comparison of the load pointer with the program
     counter, and would make executable objects completely unreadable again (guarantee 4). GOT calls would shrink from
     four to three instructions. -->

Loading the GOT slot is the only explicit access to an executable object that is permitted. It has to be an XLEN wide load (*lw* on RV32, *ld* on RV64) of index 0,
and the pointer used for it has to reference the executable object the program counter currently references.
Any other load from an executable object raises a *LoadAccessFault*, any store a *StoreAccessFault*.
This includes loading the GOT slot of another executable object, so holding a pointer to a function of another program or library never gives access to its GOT.

The hardware never writes *gp*, neither on jumps nor on traps, *mret* or *sret*. Apart from its conventional use, *gp* is an ordinary register which may be copied, stored and used in arithmetic like any other.
A trap handler obtains the GOT of the system management software the same way as any other code, after saving the registers of the interrupted program.
How the GOT pointer is kept away from the code of other executable objects is part of the [calling convention](#chap_calling_convention).

A single load relative to *gp* reaches the offsets 0 to 2047, which covers 512 slots for XLEN=32 and 256 slots for XLEN=64. The first of those slots is reserved by the linker.
Slots beyond are reached by adding the upper part of their offset to the GOT pointer first, just like any other large index (see *lui* in [RISC-V I vs I'](#riscv_i_tick)):

```asm
lui     t0, %got_off_hi(symbol)
add     t0, gp, t0
lw      t0, %got_off_lo(symbol)(t0)     # ld on RV64
```

Since the load overwrites *t0*, no register except *gp* holds a pointer into the GOT afterwards.

<!-- FIXME: open points of the GOT slot:
     * __got_slot, %got_off_hi and %got_off_lo (and their relocations) are proposals. Alternatively, the linker could
       reserve the GOT slot at the start of the code segment, so that link-time offsets equal object indices and the
       loader no longer has to add XLEN/8 for code objects.
     * Since gp is no longer exclusive, the limit of 511 GOT slots is gone, which allows one slot per static object
       (see loading a program). Still to decide: does the compiler always emit the long form, or does the linker
       relax it to a single load?
     * A software garbage collector has to read the GOT slots of all executable objects. Whether the restriction
       above applies in supervisor and machine mode has to be specified. -->

## Accessing addresses {#static}

Addresses of functions and data objects, including string literals, constant pools and jump tables, are always loaded from the GOT.
Following the [calling convention](#chap_calling_convention), the GOT pointer is either loaded into the destination register itself, which the load from the GOT then overwrites, or kept in *gp* for several accesses:

```asm
1:  auipc   a0, %pcrel_hi(__got_slot)
    lw      a0, %pcrel_lo(1b)(a0)       # a0 = GOT pointer (ld on RV64)
    lw      a0, %got_off(symbol)(a0)    # a0 = pointer to symbol (ld on RV64)

    lw      a1, %got_off(symbol)(gp)    # with the GOT pointer kept in gp
```

To tell the linker that a GOT slot has to be created for a symbol, the assembler modifier *%got_off(symbol)* along with the relocation type *R_RISCV_GOT_OFF* is introduced.
The linker replaces *%got_off(symbol)* by the offset of the symbols slot from the start of the GOT, similar to how the assembler modifiers *%hi*, *%lo* etc. are handled.
These offsets are resolved completely at link time. Only the slots themselves require work at load time, using the standard dynamic relocations of RISC-V:
*R_RISCV_RELATIVE* for targets inside the program and *R_RISCV_32*/*R_RISCV_64* along with the symbol for targets outside of it.
A call and the address of the same function share a single slot.

Since code and read-only data are separate objects, jump tables can neither be part of the code nor hold absolute addresses.
Instead, their entries hold the distance of each target from the start of the function the jump table belongs to. The base of this distance is the address of the function itself, which is obtained using *auipc*.

## Making calls {#library_calls}

Since *ra* may only be written by jumps, call sequences use *t1* instead of *ra* as temporary register.
A pc-relative call looks just like in RISC-V:

```asm
auipc   t1, %pcrel_hi(symbol)
jalr    ra, %pcrel_lo(symbol)(t1)
```

A GOT call loads the GOT pointer into *t1* and right away overwrites it with the pointer to the callee.
This way, no register holds the GOT pointer when the call leaves the executable object, and nothing has to be cleared ([calling convention](#chap_calling_convention)):

```asm
1:  auipc   t1, %pcrel_hi(__got_slot)
    lw      t1, %pcrel_lo(1b)(t1)       # t1 = GOT pointer (ld on RV64)
    lw      t1, %got_off(symbol)(t1)    # t1 = pointer to the callee, the GOT pointer is gone (ld on RV64)
    jalr    ra, 0(t1)
```

The compiler emits a pc-relative call only if it knows that the callee is defined in the same image and not preemptible, e.g. for functions with internal linkage.
For every other callee it emits a GOT call, and the linker decides whether it stays one:

| Callee                                                                  | Call becomes                                 | GOT slot                                   |
| :---------------------------------------------------------------------- | :------------------------------------------- | :----------------------------------------- |
| defined in the programs own code and not preemptible                    | *auipc* + *jalr*, relaxable to *jal*         | none                                       |
| defined in a shared library, preemptible or forced through the GOT      | GOT call                                     | *R_RISCV_32*/*R_RISCV_64* or *R_RISCV_RELATIVE* |
| undefined weak                                                          | GOT call, guarded by the programs null check | the loader writes the primitive value 0    |

If a GOT call is not needed, the linker relaxes it to a pc-relative call, which may be relaxed further to *jal*.
Since relaxation only ever shrinks a call sequence, the compiler can always emit a GOT call when it is unsure. Without relaxation, the call stays a GOT call, which is correct but slower.
A call that remains a GOT call is never relaxed to *jal*.
There is no procedure linkage table (PLT) and no lazy binding: every slot is filled at load time and a GOT call loads its target inline.

<!-- FIXME: relocations marking the four instructions of a GOT call as one group, so that the linker can recognize and
     relax it, are not defined yet. -->

## Loading a program {#loading}

Programs and shared libraries are loaded by a loader running in supervisor mode.
For every image, starting with the program and followed by every library it depends on, the loader performs the following steps:

1. For every static object in the data and read-only segments, an object of the corresponding size is allocated using *alc* and the contents of the static object are copied into it. Since allocated objects only contain the primitive value 0, this also covers zero-initialised data like *.bss*. Static objects from read-only segments never contain pointers in a PIE. They are therefore placed in data only objects whose write permission is revoked using *st* right after copying, since relocations never write to them.
2. The GOT is placed in an ordinary object of its own.
3. For every code segment, an ordinary object of XLEN/8 bytes plus the segments memory size is allocated. The GOT pointer is stored at index 0 of this object, the object is retyped as data only, the instructions are copied in starting at index XLEN/8 and the object is finally retyped as executable (see [object tags](#isa_tags)).

Then, starting with the libraries, the loader applies the dynamic relocations:

- *R_RISCV_RELATIVE*: the addend is an address inside the same image at link time. The slot is set to a pointer into the object holding the corresponding static object or code segment, with the index being the distance of the addend from the start of it. For code objects, whose instructions start at index XLEN/8 ([object tags](#isa_tags)), XLEN/8 is added to this distance. This is plain pointer arithmetic on objects created by the loader, so no *dtp* is required.
- *R_RISCV_32*/*R_RISCV_64*: the symbol is looked up in the global scope (program first, then libraries) and the resulting pointer is stored into the slot using an XLEN wide store. An undefined weak symbol results in the primitive value 0, an undefined strong symbol is an error.

Finally, the program is entered using a pointer into its code object. Neither *gp* nor *sp* need any preparation: the startup code of the program loads *gp* from the GOT slot of its code object ([global pointer](#gp)), and the first prologue of the program allocates a new frame object using *alc*/*alci*.
Before entering the program, the loader clears every register holding a pointer of the system management software, in particular its own GOT pointer.
The only place where *dtp* is required is accessing the ELF files themselves, e.g. at a physical address where the boot code placed them.

In order for the loader to know where each static object begins and ends, the linker emits a data only header along with a size field in front of every static object in the data and read-only sections of an image, and every static object gets an entry in the GOT.
The headers are data only since the contents of an image are stored untagged. The loader then creates the actual objects as described above.
This way, bounds checks also apply between different static objects of a program, at the cost of one GOT slot per static object (see the size limit of the GOT in the [global pointer](#gp) section).

<!-- FIXME: the per-object headers are not implemented in the linker yet. The current toolchain allocates one object per
     segment, which only provides bounds checks at segment granularity. -->

The init arrays of a program are run by its startup code (*_start*), not by the loader.
Thread local storage, indirect functions (IFUNC), fini arrays as well as making relocated data read-only (RELRO) are not covered by this specification yet.

# Exceptions {#exceptions}

## Enforcing correct program behaviour {#gen}

To enforce the pointer based memory access scheme, the processor will raise an *IncompatibleTypeException* when a program tries to use a primitive value to access memory.
Since the object length is known on ISA level, the processor is able to raise a *IndexOutBoundsException* when an out of bound load or store instruction is executed.
In case of such an exception, *xtval* will contain the base pointer as well as the index which was beyond the object bounds.
The processor is also able to detect whether the destination object is compatible with the current access type by checking the permission tags of the object.
In consequence, *LoadAccessFault*, *StoreAccessFault* or *IncompatibleTypeException* are raised when the corresponding flag is not set as per [object tags](#isa_tags).
*LoadAccessFault*s are triggered when the 'read' flag is cleared while *StoreAccessFault* is raised in case of a store access to an object with cleared 'write' flag.
Since executable objects have both flags cleared, every load from or store to an executable object raises one of these faults, except for loading the GOT slot of the current executable object ([global pointer](#gp)).
Trying to store pointers to a data only object marked by a set 'data only' flag will lead to a *IncompatibleTypeException*.
The same exception is triggered when trying to jump to an object which is not executable using *jalr*, when trying to do an arithmetic, logic or ordered comparison operation on two pointers referencing different objects or I/O devices, when trying any arithmetic operation other than *sub* on two pointers, when comparing a pointer with a primitive using an ordered comparison or when loading only part of an element holding a pointer.

To inform the software that an access to an ordinary or executable object would violate its bounds, a *JumpIndexOutBoundsException* is raised in case of an executable object or an *IndexOutBoundsException* in case of an ordinary object.
For executable objects, the bounds of instruction fetches start at index XLEN/8, so jumping into the GOT slot, e.g. through a null function pointer, raises a *JumpIndexOutBoundsException* as well.
Should the heap onto which new objects are allocated on reach the end of its capacity, a *HeapOverflowException* is raised.

In the context of frame objects, a total of three exceptions are added to the exception list.
A *StateException* catches access to foreign frame objects as described in [frame ownership](#frame_ownership).
Even when a frame object is owned by the currently executed function, there are still two more exceptions possible: *ForbiddenDstException* is raised when trying to store anything else than *sp* or *ra* into their slots.
*ForbiddenSrcException* checks for using these slots as specified in case of load accesses as well as for *sp* being copied into another register (see [restricted registers](#restricted_regs)).

The *IncompatibleTypeException* is raised when a pointer is written to an I/O device using its corresponding pointer.

## Restricted registers {#restricted_regs}

Some registers play a special role in RISC-ViO, which is why only certain values may be written to them in user mode:

- *sp* only accepts pointers to frame objects. Such pointers are obtained by allocating a new frame object using *alc*/*alci* or by loading the *sp* slot of a frame object.
  Moving *sp* inside its frame object by arithmetic operations writing *sp* itself, like *add sp, sp, t*, is allowed.
- *ra* only accepts the results of call and return instructions as well as values loaded from the *ra* slot of a frame object.

Writing any other value to *sp* or *ra* leads to a *ForbiddenDstException*.
*gp* is not restricted. It holds the GOT pointer by convention only ([global pointer](#gp)).

Frame objects may only be accessed through *sp*. In user mode, *sp* may therefore only be used as base register of loads and stores, as source of arithmetic operations writing *sp* itself and as source of the stores to the *sp* slot of a frame object.
Using *sp* as a source of any instruction writing another register, like *mv rX, sp*, leads to a *ForbiddenSrcException*.
This way, a pointer to a frame object can never end up in any other register or in memory outside the frame chain, which is enforced by the hardware.
The exception lists of the individual instructions refer to this section.

## Exceptions in conjunction with CSR {#exc_csr}

Since RISC-ViO allows both pointers and primitive values to be stored in the registers and also organizes code using objects, some CSR also need to be able to hold pointers.
This is the case for *xtvec* and *xepc* due to executable objects and for *xtval* and *xscratch* due to pointers in general.
To access the components of these registers, the *csrw* instruction may be used in conjunction with the *dtp*/*btd*/*itd* instructions.
Apart from this slight modification as well as the expansion of available exceptions, exceptions and interrupts behave identical to the way they do in RISC-V.

## Exception masking {#priv}

The [exception table](#t_exc) provides an overview of the exceptions corresponding to the protection schemes introduced by RISC-ViO.
In order to allow higher privilege modes to gain the access required for system management, some exceptions are suppressed in certain privilege modes.

::::::

::: divider
ISA

---

implementation
:::

:::::: imp

# Primitives and pointers in the register file {#reg_fl}

Every RISC-ViO architecture requires a register file which is able to satisfy the requirements given in the [I'](#base_spec) chapter.
Apart from these requirements, RISC-ViO does not specify how a register file of an implementation of this architecture has to look like.
This leaves room for tailoring the implemented register file to the design constraints at hand.

::: note
(Please note that in this specification, pointers are written in the form x.y where x is a pointers base address and y is the index of the pointer. To graphically set apart pointers from primitives, pointers are drawn in various shades of pink and purple.
Primitives are not denoted in any special way in text form but drawn in light blue.)
:::

## Fields {#fields}

The subarchitecture implementation offered here is meant only as an example implementation and is focused on higher performance while requiring more hardware resources. The register sections required by the RISC-ViO specification are denoted with 'ISA' while sections introduced by this particular implementation are denoted with 'IMP'. In this implementation, the 'IMP' sections are exclusively made up of object header metadata drawn in green.

::: figure
![An example implementation of a RISC-ViO register file](svg/register_file.svg)

An example implementation of a RISC-ViO register file
:::

*gp* is not treated specially by this implementation.

<!-- FIXME: check whether the register file figure still shows a special role of gp. -->

## Colouring {#coloring}

As described in the [frames](#frames) chapter and as present in the requirements list in [I'](#base_spec), RISC-ViO calls for the ability to hold colour information for both the *ra* as well as the *sp* register.
The implementation presented here is able to satisfy this requirement using the fields as shown in the last section only. In this implementation, the colour 'black' is encoded as a cleared bit ('0') while 'white' corresponds to a bit which is set ('1').
Since the smallest possible instruction size specified by RISC-V is 16 bits or two bytes, the lowest bit of the index of *ra* always has to be 0.
This is why it is possible to encode the current colour of *ra* in this bit. For *sp*, the same is not true however since its index may be set to any value.
The colour of *sp* is instead stored in the current frames header copy in the register file. More specifically, the colour-bit in this header is used for storing *sp*'s colour.

## Flags and Tags {#flgs_tgs}

In order to distinguish pointers from primitives, the provided implementation uses a tag bit for all registers which may hold both primitives and pointers. Primitives are tagged as '0' while pointers are identified by a '1' bit.
Since on ISA level, RISC-ViO only distinguishes between pointers of memory and I/O kind, only a single bit in the register file is required to keep those pointer kinds apart.
This bit is interpreted as part of the pointer and is added to the right of the pointer base address or I/O device number for I/O pointers. It corresponds to bit 0 of the reference word exchanged by *btd* and *dtp* ([raw pointer access](#raw_ptr_access)).

# Objects in memory {#hard_obj}

::::: columns

:::: column

## Headers {#headers}

Headers mark the beginning of every object. They hold all information about the object necessary to ensure proper handling of itself. Headers are always 16-Byte aligned.

::: figure
![Header Bitmap on 32-Bit Architectures](svg/objektbaukasten/header.svg)

Header Bitmap on 32-Bit Architectures
:::

| Bits   | Sym. | Details                                                  |
| :----: | :--: | :------------------------------------------------------: |
| 31:30  | gc   | Reserved for the hardware garbage collector              |
| 29     | r    | Readable                                                 |
| 28     | w    | Writable                                                 |
| 27     | d    | Data-Only                                                |
| 26     | s    | Sanctuary                                                |
| 25     | i    | Weak cell.<br>Bit 6 of the [object tags](#isa_tags)      |
| 24     | -    | Reserved, must be zero                                   |
| 23:8   | sc   | Scratch space.<br>Shifted down by one to bits 22:7 of the [object tags](#isa_tags) |
| 7      | -    | Reserved, must be zero                                   |
| 6      | c    | Color of frame objects.<br>See [Frames chapter](#frames) |
| 5      | f    | Frame object                                             |
| 4:0    | -    | Header identifier                                        |
|        |      |                                                          |
| 31:2<br>(63:3) | λ | Length of object<br>(only bits 31:2 on 32-Bit, 63:3 on 64-Bit) |
| _1_<br>_(2:1)_ | _-_ | _don't care_                                         |
| 0      | -    | Must be zero.<br>Guarantees a consistent memory model    |

_On a 64-Bit Architecture the upper bits of the header bitmap are shifted upwards to 64-Bit boundaries._

<!-- FIXME: header.svg still shows the old layout (scratch 25:7, no weak bit). -->

## Elements {#elements}

Elements of objects are tagged by the lowest Bit(s) in a chunk of memory.
On a 32-Bit architecture this chunk is 32 bits wide, on 64-Bit architectures 64 bits.

::: figure
![Word, half and byte locations in an ordinary object](svg/objektbaukasten/data.svg)

Word, half and byte locations in an ordinary object
:::

Primitives in ordinary objects are identified by the trailing *0*-Bit. If a Store is attempted, which would make the two uppermost bits of a chunk unequal (e.g. *bit-31 ≠ bit-30* on a 32-Bit Architecture)
then the primitive is stored to the current sanctuary object instead and the corresponding displacement pointer will be stored to the address the original store was attempted to.

::: figure
![Pointer to displaced data](svg/objektbaukasten/disp_prim_ptr.svg)

Pointer to displaced data
:::

These Pointers are identified by trailing *01*-Bits.

Pointers to objects are identified by trailing *0111*-Bits. They can be generated by allocation instructions and point to the head of ordinary, data-only and executable objects.

::: figure
![Pointer to an object](svg/objektbaukasten/pointer.svg)

Pointer to an object
:::

If a store is attempted on a pointer that was modified by arithmetic instructions so that its index is unequal to zero, the pointer will be displaced into the current sanctuary object and only the displacement pointer
is stored to the original address the store was attemped to.

::: figure
![Pointer to a displaced Pointer](svg/objektbaukasten/disp_ptr_ptr.svg)

Pointer to a displaced Pointer
:::

These pointers are identified by trailing *011*-Bits.

Pointers to I/O-capabilities are identified by the trailing *01111*-Bits. They hold a device-id which identify what I/O-Device is referenced.

::: figure
![I/O-Pointer](svg/objektbaukasten/io_ptr.svg)

I/O-Pointer
:::

::::

:::: column

## Ordinaries {#ords}

Ordinary objects always start with a header and can hold every element kind defined.

::: figure
![Ordinary object and its possible elements](svg/objektbaukasten/ordinary_object.svg)

Ordinary object and its possible elements
:::

## Data-Only Objects {#data-onlies}

Data-only objects are identified by the data-only bit in the Header. Primitives inside of these objects are not tagged, so they make use of the whole 64|32 Bit per element.
Pointers are forbidden inside data-only objects.

Since primitives are stored tagged in ordinary objects but untagged in data-only objects, retyping an object holding data between these two kinds changes how its contents are interpreted.
A word of a data-only object with its lowest bit set would for example be read as a pointer once the object is retyped as ordinary.
System management software should therefore only retype objects between ordinary and data-only before filling them.

::: figure
![Data-only object](svg/objektbaukasten/data_only_object.svg)

Data-only object
:::

## Executables {#execs}

Executables have only the data-only bit set in their header, with both permission bits cleared. This identifies them as an executable: a data-only object which can be neither read nor written has no use, so this combination is free to encode executable objects.\
The GOT slot ([object tags](#isa_tags)) is the third (double-)word of the object, directly behind the header, and therefore index 0 of the object, just as for any other object.
The code starts at index XLEN/8. It is stored in the same fashion as in data-only objects, so instructions can harvest the full 64|32 bit of an element.

The GOT pointer always references index 0 of a separate GOT object and is held as a tagged pointer, while the instructions behind it are untagged.
Since the GOT slot is read by an ordinary XLEN wide load, a pointer with a non-zero index would work as well, but it would be displaced into a sanctuary object and cost an additional memory access on every load of the GOT pointer.

Since index 0 refers to the GOT slot regardless of whether the object is typed as ordinary, data only or executable, pointers into code created while building an executable object stay valid once it is retyped.

<!-- FIXME: check that executable_object.svg shows the GOT slot as index 0. -->

::: figure
![Executable Object](svg/objektbaukasten/executable_object.svg)

Executable Object
:::

## Sanctuaries {#sancts}

Sanctuaries only have the Sanctuary Bit set in their header. They are used as memory space for displaced primitives and displaced pointers and cannot be referenced by ordinary pointers.\
Displaced Pointers take two element slots, one for the base pointer and one for the index, thus are always aligned to 2-Element boundaries.
The base pointer is stored as an ordinary pointer and the index as data-only primitive.\
Displaced primitives only take one element slot being the (Double-)Word that was displaced. These kinds can be stored at any element position inside the Sanctuary.

<!-- FIXME: sanctuaries and weak cells do not fit together yet. A pointer with a non-zero index stored into a weak cell
     is displaced, so the weak cell only holds a displacement pointer, while the actual pointer lies in a sanctuary slot,
     next to the displaced values of other objects. Open questions:
     * The garbage collector must not mark through the slot of a weak displaced pointer, while it has to keep the slots
       of strong displaced pointers and their objects alive. It can therefore not scan sanctuary objects like ordinary
       objects, and has to know for every slot whether it was reached from a weak cell.
     * Clearing a weak pointer means replacing the displacement pointer in the weak cell by the primitive value 0 and
       freeing its sanctuary slot. How sanctuary slots are reclaimed is not specified at all yet.
     * A concurrent collector additionally has to handle a weak displaced pointer being loaded while it is cleared.
     * Possible way out: weak cells only accept pointers with index 0 and raise an IncompatibleTypeException otherwise.
       Such pointers are never displaced, and weak references usually reference the head of an object anyway. -->

<!-- FIXME: sanctuary objects need their own figure, this is still the data-only object figure -->

::: figure
![Sanctuary Object](svg/objektbaukasten/data_only_object.svg)

Sanctuary Object
:::

::::

:::::

# Pointer and address generation {#ptr_addr}

The provided implementation example of the RISC-ViO architecture by using the object structures outlined above implies new requirements for a processor pipeline supporting this implementation.
In the next sections, a possible subarchitecture meeting those requirements shall be described.

## Allocations {#alcs}

In the presented implementation, all members of the alc instruction family place both ordinary and data only objects as well as frame objects on the heap.
There the objects lie in allocation order until a garbage collection cycle occurs. The CSR *malc* is used to keep track of the heap fill level and heap limit. *malc.ptr* keeps track of the newest objects start address while *malc.ix* contains the lower limit of the heap in form of an address.
In the process of such a cycle, objects may be moved or overwritten in case of not being required anymore.

The allocation process starts by calculating the address of the new object header.
This is given by rounding down the value given by the expression

$$
\mathrm{malc.ptr} - (2 \cdot \mathrm{XLEN}/8 + \mathrm{size})
$$

down to next number divisible by 16, where 2·XLEN/8 is the size of the object header (8 bytes for XLEN=32, 16 bytes for XLEN=64).
If this value is larger than malc.ix the new object fits inside the heap and malc.ptr is updated to this value.
In this case, a pointer tag is added to the newly calculated address and the resulting pointer value is written to the target register.
The initial index is set to zero.

To commit the header of this new object to memory, the so-called attribute cache is used.
This cache is located in the attribute stage located behind the memory stage and is mainly used to both retrieve and load object attributes.
In case of primitives with their two uppermost bits being unequal or pointers with non-zero index this cache is also used to both store and retrieve these kinds of data to and from memory.

::: figure
![Regular heap growth](svg/vio_heap_growth.drawio.svg "a) Regular heap growth")
![Heap overflow](svg/vio_heap_overflow.drawio.svg "b) Heap overflow")

Heap limits and growth.
:::

The given implementation uses sanctuary objects to cope with the requirement to distinguish between pointers and primitives in memory.
Any time a primitive with its two uppermost bits being unequal or a pointer with a non-zero index is stored, a slot of corresponding size and alignment in the current sanctuary object is used.
For primitives this alignment and size is XLEN/8 bytes while for pointers with index it is 2·XLEN/8 bytes.
The sample implementation has the sanctuary index point to the last used slot in the sanctuary object and decrements this index on every sanctuary slot allocation.

When the current sanctuary object is full, which is signified by the sanctuary index being zero, while a new sanctuary slot is required, a new sanctuary object is allocated.
For this, the current allocation address is decremented according to the implementation-dependant sanctuary object size and the sanctuary object address is set to this value.
Also, the sanctuary slot index is set to highest possible value for the new sanctuary object to be once again be filled from the top to the bottom.
In order to ensure the garbage collector being aware of this object, the attribute cache in the attribute stage also writes a header stub to the address at which the sanctuary object lies.
In the flags field of this header, the sanctuary bit marks this object as a sanctuary object.

In order to allow a system management software to control the allocation of sanctuary objects, a new CSR called *msad* is introduced. Consistent with *malc*, the pointer contained in this CSR has the address of the current sanctuary object as its base address field while the current allocation index in the sanctuary object is located in the index field of this CSR.
The CSR index of the *msad* CSR can be extracted from the [CSR table](#t_csr).

## Loading and storing a pointer {#load_store}

As the subarchitectural implementation requires some flag bit from the object header as well as its length or lambda field, those fields also have to be retrieved from memory when loading a pointer.
For this, the example subarchitectural implementation uses an additional pipeline stage called the attribute stage which is located behind the memory stage in the processor pipeline.\
The [instruction behaviour table](#t_instr_in_pipe) shows how this stage interacts with the stages that come before it, this section looks at this interaction in further detail.
After the memory stage has loaded a pointer, the attribute stage then loads the header being pointed to by the pointer base address. This header along with the actual pointer value is then handed over to the write-back stage which writes those fields into the register file.
In the given subarchitectural implementation, the attribute stage is used to accomplish additional tasks like loading full XLEN wide primitives, meaning primitives with their two uppermost bits being unequal, or a pointer with non-zero index from an object.
For the task of loading full XLEN wide primitives, it is the task of the attribute stage to load the actual primitive from memory instead of the memory stage.
This is necessary since the memory stage has to determine where this primitive is located in memory first by loading the according displacement pointer.
For pointers with a non-zero index, the attribute stage also has to become active. Since requiring both the loading of a pointers index as well as the header of the object pointed to, this operation takes two clock cycles however and therefore necessitates stalling the remaining pipeline until both operations have been completed.
In this situation, the attributes stage will load the pointer index before loading the object header and combining the loaded fields with the pointer value loaded by the memory stage and passing the combined register file entry to the writeback stage.

The process of storing register contents is analogous to the process of loading primitives as well as pointers regarding the fundamental tasks accomplished by the memory and attribute stages. The only difference other than those stages storing instead of loading is that the attribute stage might need to allocate a new 'Sanctuary object' to store XLEN wide primitives or pointers with non-zero index into.
This task is completed by a special subunit, which avoids the attribute stage having to stall the remaining pipeline when storing a XLEN primitive or pointer with non-zero index while also needing a new Sanctuary Object to be allocated.

<!-- FIXME: return addresses are the most frequent pointers with a non-zero index. Every non-leaf function stores ra into
     its frame, so with the encoding above every call displaces a pointer into a sanctuary, leaving the slot as garbage
     once the frame dies, and every return needs the two-step load of a displaced pointer. This contradicts design goal 6
     for safe and unsafe languages alike.
     Proposal: the ra slot can only hold ra, and only the function owning the frame can load it. This function always
     runs in the same executable object, so the ra slot can use an encoding of its own: if ra references the executable
     object the program counter references, only its index and colour are stored, as a primitive. Loading the slot into
     ra takes the reference, length and header from the program counter. Only return addresses into other executable
     objects (calls across images, callbacks) are still displaced. Values below XLEN/8 (an unused slot, the residue left
     by ret) remain primitives. The garbage collector and the system management software interpret such slots relative
     to the executable object of the frame's owner, which is referenced by the return address in the next younger frame,
     or by the program counter for the youngest frame.
     A JIT placing every compiled method into an executable object of its own would mostly hit the displaced case, so
     JITs should place compiled code into larger executable objects. -->

## Bounds and Flag checks {#bounds}

As the outlined subarchitecture keeps the length of the corresponding object for each pointer in the register file, it is possible to check for an out of bound access as soon as the actual access index is available.
This can be the case as early as in the execute stage, which allows for early raising of *IndexOutBoundsException*s.
Since an objects flags which signify it as being readable, writeable and data only are also available as soon as the pointer to this object is available in the processor, the conditions for *LoadAccessFault* and *StoreAccessFault* exceptions can also be tested for just as early.

# Tables {#tables}

## Instructions (zhm extension) {#t_inst}

::: encoding
| 31:25     | 24:20    | 19:15    | 14:12 | 11:7    | 6:0     | Instruction |
| :-------: | :------: | :------: | :---: | :-----: | :-----: | :---------: |
| 0000000   | rs2(src) | 00010    | 000   | rd(dst) | 0001011 | alc         |
| imm[13:2] / imm[14:3] || 00010    | 010   | rd(dst) | 0001011 | alci        |
| 0000000   | rs2(src) | 00000    | 001   | rd(dst) | 0001011 | alc.d       |
| imm[13:2] / imm[14:3] || 00000    | 011   | rd(dst) | 0001011 | alci.d      |
| 0000000   | 00000    | rs1(src) | 100   | rd(dst) | 0001011 | qsz         |
| imm[12\|10:5] | rs2 (src)| rs1 (src) | 111 | imm[4:1\|11] | 0001011 | bso |
| 0111111   | rs2(ix)  | rs1(ref) | 000  | rd(dst) | 1110011 | dtp         |
| 1011111   | 00000    | rs1(ptr) | 000   | rd(dst) | 1110011 | itd         |
| 1101111   | 00000    | rs1(ptr) | 000   | rd(dst) | 1110011 | btd         |
| 1110111   | 00000    | rs1(ptr) | 000   | rd(tags) | 1110011 | lt         |
| 1111011   | rs2(sd)  | rs1(ptr) | 000   | 00000   | 1110011 | st          |
| 1111101   | 00000    | rs1(addr) | 000  | 00000   | 1110011 | clr         |
| 1111110   | 00000    | rs1(ptr) | 000   | rd(tag) | 1110011 | sep         |
:::

## Object and pointer kinds {#t_op}

::::: columns

:::: column

#### Header

![Header](svg/objektbaukasten/header.svg)

#### Primitive

![Primitive](svg/objektbaukasten/data.svg)

#### Displacement pointer (primitive)

![Displacement pointer (primitive)](svg/objektbaukasten/disp_prim_ptr.svg)

#### Displacement pointer (pointer)

![Displacement pointer (pointer)](svg/objektbaukasten/disp_ptr_ptr.svg)

#### Ordinary pointer

![Ordinary pointer](svg/objektbaukasten/pointer.svg)

#### I/O-Pointer

![I/O-Pointer](svg/objektbaukasten/io_ptr.svg)

::::

:::: column

#### Ordinary Object

![Ordinary Object](svg/objektbaukasten/ordinary_object.svg)

#### Executable object

![Executable object](svg/objektbaukasten/executable_object.svg)

#### Data-only object

![Data-only object](svg/objektbaukasten/data_only_object.svg)

::::

:::::

## Exceptions {#t_exc}

<!-- xcause 25 was GPAccessException, which became obsolete when gp became an ordinary register. -->

<!-- FIXME: the xcause indices were moved from 16-23 to the custom use range 24-31, since 16-23
     partly collide with exception codes ratified by RISC-V (e.g. double trap, software check,
     hardware error). This is not implemented in hardware like this yet. -->

| *xcause index* | *Name*                      | *may be raised in privilege mode* |||
| ^^             | ^^                          | *user*                            | *supervisor* | *machine* |
| :------------: | :-------------------------: | :-------------------------------: | :----------: | :-------: |
| 24             | JumpIndexOutBoundsException | ✔                                 | ✔            | ✖         |
| 25             | *reserved*                  |                                   |              |           |
| 26             | IndexOutBoundsException     | ✔                                 | ✔            | ✖         |
| 27             | HeapOverflowException       | ✔                                 | ✔            | ✖         |
| 28             | StateException              | ✔                                 | ✔            | ✖         |
| 29             | ForbiddenSrcException       | ✔                                 | ✖            | ✖         |
| 30             | ForbiddenDstException       | ✔                                 | ✖            | ✖         |
| 31             | IncompatibleTypeException   | ✔                                 | ✔<sup>1</sup> | ✔<sup>1</sup> |

::: notes
1. In supervisor and machine mode, the *IncompatibleTypeException* is only raised by the privileged instructions of the zhm extension (e.g. when trying to create a pointer from a pointer using *dtp*).
:::

## CSRs {#t_csr}

| *CSR index* | *Name* | *subfields*                       ||
| ^^          | ^^     | *ptr*                             | *index*                             |
| :---------: | :----: | :-------------------------------: | :---------------------------------: |
| 0xBC0       | MALC   | current allocation address          | heap limit address                |
| 0xBC1       | MSAD   | address of current sanctuary object | current index in sanctuary object |

## Example of a Heap {#t_heap}

::: {#heap .figure}
![Example of a heap](svg/pretty_heap.svg){width=100%}
:::

## Instructions in a sample pipeline {#t_instr_in_pipe}

This table shows how a pipeline backend implementing the RISC-ViO architecture may look like.
For this, the fields of the content to be written to a register is shown in the EXecute, MEmory and the new ATtribute stage.
Also, for each stage the units which are active in this stage for the given instruction are listed. A result field value of 'pass' means that this pipeline stage will only pass along the value of rd from the prior stage while '~' means that rd is invalid and this instruction will not write anything to the register file.
The table lists the load and store instructions of RV32. On RV64, *ld* and *sd* behave like *lw* and *sw* in this table, while *lw*, *lwu* and *sw* behave like the sub-element loads and stores (*lb*/*sb* etc.).

|                            ||||| Fields and Actions by Stages ||||||||
|                            | register file indices |||       | EX                           || ME                   || AT first pass          || AT second pass ||
| Instruction                | rs1                   | rs2  | rd             | imm   | Actions                      | Results                                                    | Actions              | Results                          | Actions                | Results                         | Actions        | Results    |
| :------------------------- | :-------------------- | :--- | :------------- | :---- | :--------------------------- | :--------------------------------------------------------- | :------------------- | :------------------------------- | :--------------------- | :------------------------------ | :------------- | :--------- |
| lui                        | zero                  | zero | rd             | imm20 | ALU: add                     | rd: (T:prim, P:0, I:val, L:0, H:0)                         |                      | pass                             |                        | pass                            |                | pass       |
| auipc                      | zero                  | zero | rd             | imm20 | ALU: add                     | rd: (T:ptr, P:pc.ptr, I:val, L:pc.l, H:pc.hdr)             |                      | pass                             |                        | pass                            |                | pass       |
| jal                        | zero                  | zero | rd             | imm20 |                              | rd: (T:ptr, P:pc.ptr, I:pc.ix, L:pc.l, H:pc.hdr)           |                      | pass                             |                        | pass                            |                | pass       |
| jalr                       | rs1                   | zero | rd<sup>2</sup> | imm12 | DBU: b_tgt                   | rd: (T:ptr, P:pc.ptr, I:pc.ix, L:pc.l, H:pc.hdr)<sup>2</sup> |                      | pass                             |                        | pass                            |                | pass       |
| bcc                        | rs1                   | rs2  | zero           | disp  | ALU: comp DBU: (b_tgt)       | ~                                                          |                      | ~                                |                        | ~                               |                | ~          |
| arithi (any arith./logic op) | rs1                   | zero | rd             | imm12 | ALU: op=imm12 X rs1          | rd: (T:rs1.T, P:rs1.P, I:val, L:rs1.L, H:rs1.H)            |                      | pass                             |                        | pass                            |                | pass       |
| arithr (any arith./logic op) | rs1                   | rs2  | rd             | none  | ALU: op=rs2 X rs1            | rd: (T:val, P:val, I:val, L:val, H:val)<sup>1</sup>        |                      | pass                             |                        | pass                            |                | pass       |
| lb/lbu/lh/lhu              | rs1                   | zero | rd             | imm12 | AGU: addr                    | daddr                                                      | DC: lb/lbu/lh/lhu    | rd:(T:prim, P:0, I:val, H:0, L:0) |                        | pass                            |                | pass       |
| sb/sh<sup>3</sup>          | rs1                   | rs2  | zero           | imm12 | AGU: addr                    | daddr                                                      | DC: sb/sh            | ~                                |                        | ~                               |                | ~          |
| sb/sh<sup>4</sup>          | rs1                   | rs2  | zero           | imm12 | AGU: addr                    | daddr                                                      | DC: sw DU: alc_data  | caddr, six (sptr, aaddr)         | AC: sw (SA: alloc)     | ~                               |                | ~          |
| lw (primitive<sup>3</sup>) | rs1                   | zero | rd             | imm12 | AGU: addr                    | daddr                                                      | DC: load             | rd:(T:prim, P:0, I: val, H:0, L:0) |                        | pass                            |                | pass       |
| lw (primitive<sup>4</sup>) | rs1                   | zero | rd             | imm12 | AGU: addr                    | daddr                                                      | DC: load             | aaddr                            | AC: lw                 | rd: (T:prim, P:0, I:val, L:0, H:0) |                | pass       |
| lw pointer<sup>5</sup>     | rs1                   | zero | rd             | imm12 | AGU: addr                    | daddr                                                      | DC: load             | rd:(T:ptr, P:val, I:0, H:hdr, L:l) |                        | pass                            |                | pass       |
| lw pointer<sup>6</sup>     | rs1                   | zero | rd             | imm12 | AGU: addr                    | daddr                                                      | DC: load             | rd:(T:ptr, P:val)                | AC: lw                 | rd: ix_val                      | AC: lw         | rd: l, hdr |
| sw (primitive<sup>3</sup>) | rs1                   | rs2  | zero           | imm12 | AGU: addr                    | daddr                                                      | DC: sw               | ~                                |                        | ~                               |                | ~          |
| sw (primitive<sup>4</sup>) | rs1                   | rs2  | zero           | imm12 | AGU: addr                    | daddr                                                      | DC: sw, DU: alc_sadp | caddr, six (sptr, aaddr)         | AC: sw (SA: alloc)     | ~                               |                | ~          |
| sw pointer<sup>5</sup>     | rs1                   | rs2  | zero           | imm12 | AGU: addr                    | daddr                                                      | DC: sw               | ~                                |                        | ~                               |                | ~          |
| sw pointer<sup>6</sup>     | rs1                   | rs2  | zero           | imm12 | AGU: addr                    | daddr                                                      | DC: sw DU: alc_sadd  | caddr, six (sptr, aaddr)         | AC: sw (SA: alloc)     | ~                               |                | ~          |
| alc                        | sp                    | rs2  | rd             | none  | AGU: addr                    | rd: (T:ptr, P:val, I:0, L: val, H:val), aaddr,caddr        |                      | pass                             | AC: sw [object header] | pass                            |                | pass       |
| alci                       | sp                    | zero | rd             | imm12 | AGU: addr                    | rd: (T:ptr, P:val, I:0, L: val, H:val), aaddr,caddr        |                      | pass                             | AC: sw [object header] | pass                            |                | pass       |
| alc.d                      | zero                  | rs2  | rd             | none  | AGU: addr                    | rd: (T:ptr, P:val, I:0, L: val, H:val), aaddr,caddr        |                      | pass                             | AC: sw [object header] | pass                            |                | pass       |
| alci.d                     | zero                  | zero | rd             | imm12 | AGU: addr                    | rd: (T:ptr, P:val, I:0, L: val, H:val), aaddr,caddr        |                      | pass                             | AC: sw [object header] | pass                            |                | pass       |
| qsz                        | rs1                   | zero | rd             | none  | PGU: rd                      | rd: (T:prim, P:0, I:val, L:0, H:0)                         |                      | pass                             |                        | pass                            |                | pass       |
| bso                        | rs1                   | rs2  | zero           | disp  | ALU: comp DBU: (b_tgt)       | ~                                                          |                      | ~                                |                        | ~                               |                | ~          |
| dtp                        | rs1                   | rs2  | rd             | none  | AGU: addr                    | rd: (T:ptr, P:val, I:val), caddr                           |                      | pass                             | AC: lw [object header] | rd: (L:val, H:val)              |                | pass       |
| btd                        | rs1                   | zero | rd             | none  | PGU: rd                      | rd: (T:prim, P:0, I:val, L:0, H:0)                         |                      | pass                             |                        | pass                            |                | pass       |
| itd                        | rs1                   | zero | rd             | none  | PGU: rd                      | rd: (T:prim, P:0, I:val, L:0, H:0)                         |                      | pass                             |                        | pass                            |                | pass       |
| sep                        | rs1                   | zero | rd             | none  | PGU: rd                      | rd: (T:prim, P:0, I:val, L:0, H:0)                         |                      | pass                             |                        | pass                            |                | pass       |
| lt                         | rs1                   | zero | rd             | none  | PGU: rd                      | rd: (T:prim, P:0, I:val, L:0, H:0)                         |                      | pass                             |                        | pass                            |                | pass       |
| st                         | rs1                   | rs2  | zero           | none  | AGU: addr                    | aaddr                                                      |                      | ~                                | AC: sw [object header] | ~                               |                | ~          |
| clr                        | rs1                   | zero | zero           | none  | AGU: addr                    | daddr                                                      | DC: sw               | ~                                |                        | ~                               |                | ~          |

Abbreviations used in the table:

::::: columns

:::: column

- daddr: data cache address
- aaddr: attribute cache address
- caddr: malc current address
- six: sanctuary slot index
- sptr: sanctuary object pointer

::::

:::: column

- T: tag (prim=primitive, ptr=pointer)
- P: pointer value
- I: pointer index or primitive value
- L: object length
- H: object header
- DU: displacement unit (manages displacement to sanctuary objects)
- SA: sanctuary allocator

::::

:::: column

- DC: data cache
- AC: attribute cache
- AGU: address generation unit
- ALU: arithmetic logic unit
- DBU: dynamic branch unit
- PGU: pointer generation unit

::::

:::::

::: notes
1. The values of T, P, L and H are dependent on both the values of rs1, rs2 as well as the given operation, following the rule outlined in the [pointers and primitives](#data_vs_pointers) section.
2. For the ret variant of jalr, the target index of rd used for the writeback into the register file is ra while the target value is only the color bit in the index field with everything else being zero.
3. For bit XLEN-1 = bit XLEN-2
4. For bit XLEN-1 ≠ bit XLEN-2
5. For index = 0
6. For index ≠ 0
:::

::::::

# Acknowledgements {#acknowledgements}

RISC-ViO is inspired by the Objective-RISC architecture[^meyer_orisc][^orisc_spec], which showed that raising the hardware to the level of objects yields bounds checks, unforgeable pointers, protected frames and exact garbage collection from a single model.
The way the example implementation tags pointers and primitives in the low-order bits of each memory element is inspired by the object representation of MicroPython[^micropython], which tells small integers, interned strings and pointers apart by the lowest bits of a machine word.

<!-- FIXME: add the people, institutions and funding to be thanked, if any. -->

# References {#chap_refs}

::: references
[^chromium_ms]: The Chromium Projects: "Memory safety". <https://www.chromium.org/Home/chromium-security/memory-safety>, Last accessed 31.10.2026
[^msrc]: M. Miller: "Trends, challenges, and strategic shifts in the software vulnerability mitigation landscape", BlueHat IL, 2019.
[^mte]: K. Serebryany: "ARM Memory Tagging Extension and How It Improves C/C++ Memory Safety" in ;login: The USENIX Magazine 44, 2019.
[^tiktag]: J. Kim et al.: "TikTag: Breaking ARM's Memory Tagging Extension with Speculative Execution", arXiv:2406.08719, 2024.
[^apple_mie]: Apple Security Engineering and Architecture: "Memory Integrity Enforcement: A complete vision for memory safety in Apple devices", 09.09.2025. <https://security.apple.com/blog/memory-integrity-enforcement/>
[^riscv_mt]: RISC-V International: "Memory Tagging" task group (RVG-161). <https://jira.riscv.org/browse/RVG-161>, Last accessed 31.10.2026
[^cheri]: R. N. M. Watson et al.: "Capability Hardware Enhanced RISC Instructions: CHERI Instruction-Set Architecture (Version 9)", Technical Report UCAM-CL-TR-987, University of Cambridge, 2023.
[^cheri_rvy]: RISC-V International: "RISC-V Specification for CHERI Extensions". <https://riscv.github.io/riscv-cheri/>, Last accessed 31.10.2026
[^cheri_concentrate]: J. Woodruff et al.: "CHERI Concentrate: Practical Compressed Capabilities" in IEEE Transactions on Computers 68(10), 2019.
[^joannou_tags]: A. Joannou et al.: "Efficient Tagged Memory" in Proceedings of the IEEE International Conference on Computer Design (ICCD), 2017.
[^cornucopia]: N. W. Filardo et al.: "Cornucopia: Temporal Safety for CHERI Heaps" in Proceedings of the IEEE Symposium on Security and Privacy, 2020.
[^meyer_orisc]: M.Meyer: "A Novel Processor Architecture with Exact Tag-Free Pointers" in Proceedings of the 2nd Workshop on Application Specific Processors., 2003.
[^orisc_spec]: M. Meyer: "Objective-RISC User-Mode ISA Specification", draft, revision 351, University of Stuttgart, 2026. <https://content.ikr.uni-stuttgart.de/Content/Objective-RISC/objective-risc_user_mode_spec.html>
[^android_safe_coding]: J. Vander Stoep, A. Rebert: "Eliminating Memory Safety Vulnerabilities at the Source", Google Security Blog, 25.09.2024. <https://security.googleblog.com/2024/09/eliminating-memory-safety-vulnerabilities-Android.html>
[^boehm]: H.-J. Boehm, M. Weiser: "Garbage Collection in an Uncooperative Environment" in Software: Practice and Experience 18(9), 1988.
[^appel]: A. W. Appel: "Garbage Collection Can Be Faster Than Stack Allocation" in Information Processing Letters 25(4), 1987.
[^micropython]: D. P. George et al.: "MicroPython", object representations (MICROPY_OBJ_REPR) in py/mpconfig.h. <https://github.com/micropython/micropython>, Last accessed 31.10.2026
:::

# Appendix {#appendix}

## Boot Process {#boot}

After system reset, all registers are initialised with the primitive value 0. Also, both *malc* and *msad* contain the value 0x0.0x0.
Regarding [frame ownership](#frame_ownership), the colour of *sp* is white (1) after reset while the colour of *ra* is black (0), which means that the processor starts up in the irregular state.

<!-- FIXME: the reset state of the colours (sp = 1, ra = 0) needs further discussion -->

The subarchitectural register that contains the current executable object length also contains the value 0, while the index of the program counter is XLEN/8, the index of the first instruction behind the GOT slot of the code object at address zero.

### Boot image {#boot_image}

The boot image is loaded at physical address zero. Since there is no loader yet at that point, all objects of the system management software are laid out in the image by the linker, including their headers.
Each object starts at a 16 byte aligned address, and the next object follows at the next 16 byte aligned address after the end of the previous one.

| Object                      | Kind       | Content                                                                                      |
| :-------------------------- | :--------- | :------------------------------------------------------------------------------------------- |
| code                        | executable | header at address zero, followed by the GOT slot (index 0) and the first instruction (index XLEN/8, address 0xC on RV32) |
| read-only data              | data only  | constants and string literals, used in place                                                 |
| writable data (template)    | data only  | GOT, tables of pointers, initialised data and zero-initialised data                          |
| relocations                 | data only  | the dynamic relocations of the system management software                                    |
| files                       | data only  | one object per appended ELF file (program first, then libraries), ended by an empty object   |

All data objects of the image are data only, since the image holds every word untagged, just as data only objects store them in memory (see [data-only objects](#data-onlies)).
Read as ordinary objects, the same words would be interpreted differently and could even be mistaken for pointers.
As the appended files are read in place and stay in use while the program runs, the heap set up by *malc* must not overlap the image.

### Boot sequence {#boot_sequence}

Directly after reset, the program counter is not a pointer yet. In this raw mode, only straight-line code is possible. The system management software therefore starts as follows:

1. Both *malc* and *msad* are set to reasonable values using the *csrw* instruction.
2. An ordinary object of the size of the writable data template is allocated using *alc* and the template is copied into it word by word. This way, every word is stored the way ordinary objects hold primitives. Index 0 of this copy is the start of the GOT.
3. A pointer to the code object is created using *dtp*. Using *st*, the code object is retyped as ordinary, the pointer to the GOT is stored into its GOT slot at index 0 (see [executables](#execs)), and the object is retyped as executable again.
4. The system management software jumps to the instruction following the jump through a pointer into its own code object. This jump loads the attributes of the code object. Afterwards, the GOT pointer is loaded from the GOT slot into *gp*, just as in any other function ([global pointer](#gp)).

The jump of step 4 may for example look like this on RV32, with its target index being a constant:

```asm
0x0.0x4:  dtp     t0, zero, zero  # pointer to the code object at address zero (reference word 0)
0x0.0x8:  jalr    zero, t0, 12    # jump in there, to index 12, the instruction just after this jalr
```

From then on, the system management software runs in pointer mode:

5. The trap vector *mtvec* is set to a pointer into the code object.
6. The dynamic relocations of the system management software are applied. The linker could only write link-time addresses into the GOT and into initialised pointers, so each of them is turned into a pointer into the code object, the read-only data object or the copy of the writable data. Since the image is linked as a static PIE, only *R_RISCV_RELATIVE* occurs.
   This step cannot be skipped: the constant data of the system management software is only reachable through the GOT, and only the boot code can turn these numbers into pointers.
7. Since the processor starts up in the irregular state, a frame object has to be allocated using *alc* or *alci* before any function can be called. With compiled code, this is done by the prologue of the first function called.
8. The program and its libraries are loaded as described in [loading a program](#loading).
9. The program is entered in user mode: *mepc* is set to a pointer to its entry point and *mstatus.MPP* is set to user mode. Before executing *mret*, all frame objects of the system management software are released, so the frames of the program do not chain onto them, and every register holding a pointer of the system management software, *gp* in particular, is cleared. The program loads its own GOT pointer in its startup code.

From then on, the system management software only runs in traps.

## Supervisor services {#services}

User code reaches the services of the system management software using *ecall*.
The number of the requested service is passed in *a7*, its arguments in *a0* to *a2*. The result is returned in *a0*, while all other registers are preserved.
The standard services use the service numbers of Linux on RISC-V so they are easy to recognize, while RISC-ViO specific services use numbers of the form 0x7a6x.

| Service      | *a7*     | Arguments                          | Result                                                        |
| :----------- | :------: | :--------------------------------- | :------------------------------------------------------------ |
| read         | 63       | *a0* fd, *a1* buffer, *a2* length  | bytes read or −errno                                          |
| write        | 64       | *a0* fd, *a1* buffer, *a2* length  | bytes written or −errno                                       |
| exit         | 93       | *a0* status                        | does not return                                               |
| abort        | 0x7a61   | none                               | does not return                                               |
| word compare | 0x7a63   | *a0*, *a1* two words               | byte order result for primitives, 1 if either is a pointer    |
| type query   | 0x7a68   | *a0* pointer                       | normalized flags of the referenced object, 0 for a primitive  |
| identity number | 0x7a69  | *a0* pointer                       | identity number of the referenced object, 0 for a primitive   |
| weak cell    | 0x7a6b   | *a0* size in bytes                 | pointer to a new weak cell or −errno                          |

The word compare service allows *memcmp* to determine the byte order of two differing words without trapping on pointers, since user code can neither load single bytes of a pointer nor tell a pointer from a primitive.
The type query service gives user code access to the kind and permissions of an object, which only *lt* can read. Its result is normalized and never contains the raw tags.
The system management software may restrict the type query to certain code objects, e.g. those of shared libraries.

Runtimes compare and hash objects by identity in user mode, e.g. for identity hash maps or ordered collections of objects.
Addresses cannot be used for this, since the garbage collector may move objects and user code cannot read the reference field of a pointer.
Whether two pointers reference the same object is checked using *bso*. For ordering and hashing, every object can be given an *identity number*, which is kept in the scratch field of its tags.
Since only *lt* and *st* can access the tags, the identity number service is the only part handled by the system management software:
it reads the tags of the referenced object using *lt* and returns the content of the scratch field. If it is still 0, the service first copies a counter kept in one of its own objects into the scratch field using *st* and increments the counter afterwards.
The counter starts at 1, so 0 always means that no identity number has been assigned yet, and the service returns 0 for a primitive.
Identity numbers are only assigned on request: objects for which no identity number is ever requested never receive one and do not advance the counter.
Since tags move along with an object when the garbage collector moves it, identity numbers stay stable for the lifetime of an object.
A runtime orders two different objects by comparing their identity numbers, and uses the identity number as hash value, e.g. keeping it in its hash table entries for rehashing.

The weak cell service allocates a new [weak cell](#isa_tags) of the given size, since user code cannot set the 'i' bit itself.

The trap handler serving these requests has to save and restore registers using XLEN wide loads and stores, since they may hold pointers.
After serving a request, the saved program counter is advanced by 4 and all registers except *a0* are restored unchanged, as compilers rely on this around every *ecall*.
Services receiving a buffer check that the argument is a pointer and that the whole range lies inside its object before accessing it.
The system management software itself does not use these services, since an *ecall* would trap into itself. Its own library functions access the hardware directly instead.

<!-- OPEN FOR DEBATE: lightweight services. Short services like the type query or the identity number service could be
     treated like normal function calls instead of saving and restoring the whole register state. They would follow the
     calling convention: the callee-saved registers (s0 to s11) as well as sp, ra, gp and the colours stay unchanged,
     while the caller-saved registers may change. Such a service is short enough to run without a frame of its own, so
     its trap handler saves nothing beyond the registers it actually needs from the callee-saved set, often none.
     Issues:
     * Compilers have to treat an ecall to such a service like a call, i.e. as clobbering the caller-saved registers. The
       set of lightweight services and the registers they may change become part of the ABI.
     * Treating these services like calls also means treating them like calls into another executable object: a
       caller-saved register the service has used must not be left holding a value of the system management software,
       like its GOT pointer or a pointer to the object keeping the identity counter. The service clears such registers
       instead of restoring them, which is still cheaper than saving and restoring them.
     * The trap handler has to recognise a lightweight service (xcause and a7) before it saves anything, so its entry
       needs a register of its own, e.g. by swapping it with xscratch.
     * Interrupts and all other exceptions still save and restore the whole state, since the interrupted code does not
       expect any register to change. -->

<!-- FIXME: open points of the identity number and weak cell services:
     * With 16 scratch bits, identity numbers repeat after 65535 assignments (the counter has to skip 0 when it wraps).
       This is acceptable for hashing, but from then on two different objects may have the same identity number, so
       ordering by identity numbers is no longer total.
     * If identity numbers were only used for ordering, the garbage collector could renumber the identity numbers of
       live objects in their existing order once the counter runs out, which only fails with more than 65535 numbered
       objects alive at once. Identity numbers used as hash values must never change, so this is not possible for them.
     * Every hash table lookup with an object as key needs the identity number of the key, i.e. an ecall. Making lt
       usable in user mode (see the OPEN FOR DEBATE note at lt) would leave the ecall to the first request of an object only.
     * The service number of the weak cell service is a placeholder. -->

<!-- FIXME: the word compare service is still a proposal, and the bit layout of the normalized type query flags
     (readable, writable, data only, executable, weak cell, valid) has to be fixed here. -->

## Implementation notes {#implemenation_notes_chap}

The provided behaviour of the example of an RISC-ViO implementation can be further specified. This list provides an incomplete list of recommendations for such an implementation:

1. The dtp instruction should only load the header of a pointer if a valid pointer is specified via the rs1 register. Otherwise, the header and length fields in the pipeline should be set to 0.
2. A concurrent garbage collector has to make sure that a pointer loaded from a weak cell during a collection cycle keeps its object alive, e.g. by marking the object on such a load.

## Glossary and abbreviations {#abbrevs_gloss}

1. XLEN - base integer ISA width (i.e. 32 for RV32)
2. index - object field offset contained in a pointer
3. offset - object field offset being part of an instruction
4. tag - bits making up a kind information
5. flag - a bit for a singular permission
6. primitive - register or memory content which is not a pointer, like a number or a character
7. pointer - reference to an object or I/O device, made up of a reference field and an index
8. kind - the purpose of an object or I/O device as given by its tags (ordinary, data only, executable or io)
9. permission - right to read or write an object or I/O device, given by the 'r' and 'w' bits of its tags
10. frame (object) - object holding the local data of a function, taking the place of a stack frame in conventional architectures
11. colour - ownership information held by *sp* and *ra* in order to protect frame objects from foreign accesses
12. sanctuary (object) - implementation specific object holding displaced primitives and pointers
13. displacement pointer - implementation specific element in memory referencing a displaced primitive or pointer inside a sanctuary object
14. argument object - object holding the function arguments which do not fit into the argument registers *a0* to *a6*, passed in *a7*
15. GOT - global offset table, an ordinary object holding the pointers a program needs to reach functions and data outside of its own code
16. GOT slot - the first XLEN/8 bytes of an executable object, holding the pointer to the GOT of its program
17. weak cell - ordinary object with the 'i' bit set, whose pointers do not keep the objects they reference alive and are replaced by the primitive value 0 once these objects have been collected
18. reference word - primitive representation of the reference field of a pointer used by *btd* and *dtp*, with bit 0 telling pointers to objects and pointers to I/O devices apart
19. identity number - number kept in the scratch field of the tags of an object, assigned by the system management software on request and used by runtimes to order and hash objects by identity