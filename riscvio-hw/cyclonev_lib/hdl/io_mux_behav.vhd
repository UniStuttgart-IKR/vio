LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
LIBRARY ieee;
USE ieee.numeric_std.all;

ARCHITECTURE behav OF io_mux IS
    constant UART_DEV: std_logic_vector(11 downto 0) := std_logic_vector(to_unsigned(1, 12));
    constant SEVENS_DEV: std_logic_vector(11 downto 0) := std_logic_vector(to_unsigned(2, 12));
    constant LEDG_DEV: std_logic_vector(11 downto 0) := std_logic_vector(to_unsigned(3, 12));
BEGIN

    process(all) is
    begin
        uart_active <= false;
        uart_mode <= holiday;
        uart_ix <= (others => '0');
        uart_wdata <= (others => '0');


        seven_active <= false;
        seven_mode <= holiday;
        seven_ix <= (others => '0');
        seven_wdata <= (others => '0');

        io_stall <= '0';
        io_rdata <= (others => '0');

        case(io_dev) is
        when UART_DEV =>
            uart_active <= true;
            uart_mode <= io_mode;
            uart_ix <= io_ix;
            uart_wdata <= io_wdata;
            io_stall <= uart_stall;
            io_rdata <= uart_rdata;

        when SEVENS_DEV =>
            seven_active <= true;
            seven_mode <= io_mode;
            seven_ix <= io_ix;
            seven_wdata <= io_wdata;
            io_stall <= seven_stall;
            io_rdata <= seven_rdata;

        when others => null;
        end case;

    end process;

END ARCHITECTURE behav;