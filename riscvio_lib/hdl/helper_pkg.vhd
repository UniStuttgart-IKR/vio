LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
PACKAGE helper IS

    pure function minOf2(a: integer; b: integer) return integer;
    pure function maxOf2(a: integer; b: integer) return integer;
    pure function isAllStd(a: std_logic_vector; val: std_logic) return boolean;
    pure function isAllBool(a: boolean_vector; val: boolean) return boolean;
    pure function getFirstBool(a: boolean_vector; val: boolean) return natural;
    pure function getFirstStd(a: std_logic_vector; val: std_logic) return natural;
    pure function revWords(a: std_logic_vector) return std_logic_vector;
    pure function revBytes(a: std_logic_vector) return std_logic_vector;
    pure function revNibbles(a: std_logic_vector) return std_logic_vector;

END helper;