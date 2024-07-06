PACKAGE BODY helper IS

    pure function minOf2(a: integer; b: integer) return integer is
    begin
        if a > b then
            return b;
        else
            return a;
        end if;
    end function;


    pure function maxOf2(a: integer; b: integer) return integer is
    begin
        if a > b then
            return a;
        else
            return b;
        end if;
    end function;


    pure function isAllStd(a: std_logic_vector; val: std_logic) return boolean is
    begin
        for i in a'range loop
            if a(i) /= val then
                return false;
            end if;
        end loop;
        return true;
    end function;

    pure function isAllBool(a: boolean_vector; val: boolean) return boolean is
    begin
        for i in a'range loop
            if a(i) /= val then
                return false;
            end if;
        end loop;
        return true;
    end function;

    pure function getFirstBool(a: boolean_vector; val: boolean) return natural is
    begin
        for i in a'range loop
            if val = a(i) then
                return i;
            end if;
        end loop;

        return 0;
    end function;

    pure function getFirstStd(a: std_logic_vector; val: std_logic) return natural is
    begin
        for i in a'range loop
            if val = a(i) then
                return i;
            end if;
        end loop;

        return 0;
    end function;

    pure function revWords(a: std_logic_vector) return std_logic_vector is
        variable tmp: std_logic_vector(a'length - 1 downto 0);
    begin
        for i in a'length/32 - 1 downto 0 loop
          tmp((i+1) * 32 - 1 downto i*32) := a(a'length - i * 32 - 1 downto a'length - (i + 1) * 32);
        end loop;
    
    return tmp;
    end function revWords;
    
    pure function revBytes(a: std_logic_vector) return std_logic_vector is
    variable tmp: std_logic_vector(a'length - 1 downto 0);
    begin
    for i in a'length/8 - 1 downto 0 loop
        tmp((i+1) * 8 - 1 downto i*8) := a(a'length - i * 8 - 1 + a'right downto a'length - (i + 1) * 8 + a'right);
    end loop;

    return tmp;
    end function revBytes;

    pure function revNibbles(a: std_logic_vector) return std_logic_vector is
    variable tmp: std_logic_vector(a'length - 1 downto 0);
begin
    for i in a'length/4 - 1 downto 0 loop
      tmp((i+1) * 4 - 1 downto i*4) := a(a'length - i * 4 - 1 downto a'length - (i + 1) * 4);
    end loop;

return tmp;
    end function revNibbles;

END helper;
