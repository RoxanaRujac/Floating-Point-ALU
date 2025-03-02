library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_principal is
end testbench_principal;

architecture Behavioral of testbench_principal is

    -- Component Under Test (CUT)
    component fp_top_level is
     Port (
        op      : in std_logic;
        reset   : in std_logic;
        anod    : out std_logic_vector(3 downto 0);
        catod   : out std_logic_vector(7 downto 0);
        result  : out std_logic_vector(31 downto 0)
       );
    end component;


    signal op        : std_logic;
    signal reset     : std_logic;
    signal anod      : std_logic_vector(3 downto 0);
    signal catod     : std_logic_vector(7 downto 0);
    signal result    : std_logic_vector(31 downto 0);
    signal clk       : std_logic := '0';

begin

    -- Instantiate
    c: fp_top_level port map (
        op      => op,
        reset   => reset,
        anod    => anod,
        catod   => catod,
        result  => result 
    ); 
    
    -- Change of operation
    process
    begin
        op <= '0';
        wait for 10 ns;
        op <= '1';
        wait for 10 ns;
    end process;
    
    -- Clock generation 
    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Stimulus Process
    

end Behavioral;