library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity normalize is
  Port (mantissa : in std_logic_vector(23 downto 0);
        exponent : in std_logic_vector(7 downto 0);
        mantissa_normalized : out std_logic_vector(22 downto 0);
        exponent_normalized : out std_logic_vector(7 downto 0)
        );
end normalize;

architecture Behavioral of normalize is
begin

    process(mantissa, exponent)
        variable mnt : std_logic_vector (23 downto 0) := (others => '0');
        variable exp : unsigned(7 downto 0) := (others => '0');
    begin
    
        mnt := mantissa;
        exp := unsigned(exponent);
        
        if mnt(23) = '0' then --needs normalization
            while mnt(23) = '0' and exp > 0 loop
                mnt := mnt(22 downto 0) & '0';
                exp := exp - 1;
            end loop;
       end if;
       
       mantissa_normalized <= mnt(22 downto 0);
       exponent_normalized <= std_logic_vector(exp);
       
    end process;         

end Behavioral;
