library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity right_shift is
  Port (mantissa : in std_logic_vector(22 downto 0);
        shift_amount : in std_logic_vector(7 downto 0);
        mantissa_out : out std_logic_vector(23 downto 0)
        );
end right_shift;

architecture Behavioral of right_shift is
signal mnt : std_logic_vector(23 downto 0 ):= '1' & mantissa;
begin
    
    process(mantissa, shift_amount, mnt)
    begin
        mnt <= '1' & mantissa;
        mantissa_out <= std_logic_vector(unsigned(mnt) srl to_integer(unsigned(shift_amount)));
    end process;

end Behavioral;
