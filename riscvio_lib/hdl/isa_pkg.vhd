--
-- VHDL Package Header riscvio_lib.isa
--
-- Created:
--          by - rbnlux.ckoehler (pc037)
--          at - 16:28:31 04/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
PACKAGE isa IS
    constant DWORD_SIZE: natural := 64;
    constant WORD_SIZE: natural := 32; 
    constant HALF_WORD_SIZE: natural := 16;
    constant BYTE_SIZE: natural := 8;
    constant INSTRUCTION_SIZE: positive := 4;

    subtype word_T is std_logic_vector(WORD_SIZE - 1 downto 0);
    subtype dword_T is std_logic_vector(DWORD_SIZE - 1 downto 0);
    subtype half_double_word_T is std_logic_vector(HALF_WORD_SIZE - 1 downto 0);
    subtype byte_T is std_logic_vector(BYTE_SIZE - 1 downto 0);
    
    subtype register_index_T is natural range 0 to 31;
    
    type register_mode_T is (DATA, POINTER);
      
    type register_T is record
      mode: register_mode_T;
      data: dword_T;
      pi: dword_T;
      delta: dword_T;
    end record register_T;
    
    
END isa;
