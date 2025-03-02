library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity alu is
  Port (mantissa_1 : in std_logic_vector(22 downto 0);
        mantissa_2 : in std_logic_vector(23 downto 0);
        s1 : in std_logic;
        s2 : in std_logic;
        result_sign : out std_logic;
        result_mantissa : out std_logic_vector(23 downto 0)
        );
end alu;

architecture Behavioral of alu is

signal mantissa1 : std_logic_vector(23 downto 0) := '1' & mantissa_1;

begin

    process(mantissa1, s1, s2, mantissa_1, mantissa_2)
    begin
    
        mantissa1 <= '1' & mantissa_1;
     
            if s1 = s2 then
                result_mantissa <= mantissa1 + mantissa_2;
                result_sign <= s1;
            else
                if mantissa1 > mantissa_2 then
                    result_mantissa <= mantissa1 - mantissa_2;
                    result_sign <= s1;
                else
                    result_mantissa <= mantissa_2 - mantissa1;
                    result_sign <= s2;
                end if;
            end if;
          
    end process;  

end Behavioral;