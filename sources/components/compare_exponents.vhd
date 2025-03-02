library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity compare_exponents is
  Port (exponent1 : in std_logic_vector(7 downto 0);
        exponent2 : in std_logic_vector(7 downto 0);
        diff : out std_logic_vector (7 downto 0);
        less : out std_logic;
        equal : out std_logic;
        greater : out std_logic
        );
end compare_exponents;

architecture Behavioral of compare_exponents is

begin

    process(exponent1, exponent2)
    begin
        if exponent1 < exponent2 then
            diff <= exponent2 - exponent1;
            less <= '1';
            equal <= '0';
            greater <= '0';           
            
        elsif exponent1 > exponent2 then
            diff <= exponent1 - exponent2;
            less <= '0';
            equal <= '0';
            greater <= '1'; 
            
        else 
            diff <= "00000000";
            less <= '0';
            equal <= '1';
            greater <= '0'; 
        end if;
    end process;
     

end Behavioral;
