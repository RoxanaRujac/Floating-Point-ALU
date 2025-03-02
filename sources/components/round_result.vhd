library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity round_result is
    Port (
        mantissa_in : in std_logic_vector(22 downto 0); 
        mantissa_out : out std_logic_vector(22 downto 0)
    );
end round_result;

architecture Behavioral of round_result is
begin
    process(mantissa_in)
    begin
        if mantissa_in(0) = '1' then
            mantissa_out <= mantissa_in + "00000000000000000000001";
         else
            mantissa_out <= mantissa_in;
        end if;
    end process;
end Behavioral;
