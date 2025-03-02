library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_add is
end testbench_add;

architecture Behavioral of testbench_add is

    -- Component Under Test (CUT)
    component add_top_level is
    Port (
         first_number    : out std_logic_vector(31 downto 0);
         second_number    : out std_logic_vector(31 downto 0);
         result_out    : out std_logic_vector(31 downto 0)        );
    end component;


  
    signal result_out    : std_logic_vector(31 downto 0);
    signal first_number, second_number : std_logic_vector(31 downto 0);

    -- Clock and control
    signal clk              : std_logic := '0';

begin

    -- Instantiate the CUT
    uut: add_top_level
        Port map (
            first_number => first_number,
            second_number => second_number,
            result_out => result_out
           );

    -- Clock generation (50 MHz clock)
    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Stimulus Process
    

end Behavioral;