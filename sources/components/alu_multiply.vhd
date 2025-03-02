library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity alu_multiply is
  Port (mantissa_1 : in std_logic_vector(22 downto 0);
        mantissa_2 : in std_logic_vector(22 downto 0);
        exponent_1 : in std_logic_vector(7 downto 0);
        exponent_2 : in std_logic_vector(7 downto 0);
        s1 : in std_logic;
        s2 : in std_logic;
        result_sign : out std_logic;
        result_exponent : out std_logic_vector(7 downto 0);
        result_mantissa : out std_logic_vector(23 downto 0)
 );
end alu_multiply;

architecture Behavioral of alu_multiply is
  signal temp_mantissa : unsigned(47 downto 0) := (others => '0');
  signal temp_exponent : unsigned(8 downto 0);

  begin

      result_sign <= s1 xor s2;
      temp_exponent <= unsigned(exponent_1) + unsigned(exponent_2) - to_unsigned(127, 9);
      temp_mantissa <= unsigned('1' & mantissa_1) * unsigned('1' & mantissa_2);
      
      result_exponent <= std_logic_vector(temp_exponent(7 downto 0));
      result_mantissa <= std_logic_vector(temp_mantissa(46 downto 23)); 
  
  
end Behavioral;
