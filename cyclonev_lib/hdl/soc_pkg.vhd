LIBRARY ieee;
USE ieee.std_logic_1164.all;


PACKAGE soc IS
    type synthSW_T is (SYNTH, SIM, AUTO);
    constant is_synth: std_logic := '1'
    --synthesis translate_off
    xor '1'
    --synthesis translate_on
    ;

    constant UART_SSSWITCH: synthSW_T := SYNTH;


    constant UART_BAUD_SIM: natural := 1562500;
    constant UART_BAUD_SYNTH: natural := 19_200;
    constant UART_SIM: boolean :=(UART_SSSWITCH = SIM or (UART_SSSWITCH = AUTO and is_synth = '0'));


    constant SYSCLK: natural := 50_000_000;
END soc;
