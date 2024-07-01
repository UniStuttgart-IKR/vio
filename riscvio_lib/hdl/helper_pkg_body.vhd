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


END helper;
