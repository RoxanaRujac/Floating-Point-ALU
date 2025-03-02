library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiply_top_level is
  Port (
        first_number  : out std_logic_vector(31 downto 0);
        second_number : out std_logic_vector(31 downto 0);
        result_out    : out std_logic_vector(31 downto 0) -- Final floating-point result
        );
end multiply_top_level;

architecture Behavioral of multiply_top_level is

    component fp_register_file is
        Port (
            read_address : in std_logic_vector(1 downto 0);  -- Address for reading (2 bits for 4 registers)
            data_out : out std_logic_vector(31 downto 0)     -- Output data (32-bit floating-point)
        );
    end component;
    
    component alu_multiply is
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
    end component;
    
    component normalize is
      Port (mantissa : in std_logic_vector(23 downto 0);
            exponent : in std_logic_vector(7 downto 0);
            mantissa_normalized : out std_logic_vector(22 downto 0);
            exponent_normalized : out std_logic_vector(7 downto 0)
            );
    end component;
    
    component round_result is
        Port (
            mantissa_in : in std_logic_vector(22 downto 0); 
            mantissa_out : out std_logic_vector(22 downto 0)
        );
    end component;

    signal operand1, operand2          : std_logic_vector(31 downto 0);
    signal exponent1, exponent2        : std_logic_vector(7 downto 0);
    signal mantissa1, mantissa2        : std_logic_vector(22 downto 0);
    
    signal final_sign           : std_logic;
    signal result_exponent      : std_logic_vector(7 downto 0);
    signal result_mantissa      : std_logic_vector(23 downto 0);
    signal normalized_mantissa  : std_logic_vector(22 downto 0);
    signal final_exponent  : std_logic_vector(7 downto 0);
    
   signal final_mantissa  : std_logic_vector(22 downto 0);



begin
    
     -- Register File to Fetch Operands
    fp_register_1: fp_register_file port map(
        read_address => "10",
        data_out     => operand1
    );

    fp_register_2: fp_register_file port map(
        read_address => "11",
        data_out     => operand2
    );
    

    -- Extract Fields (Sign, Exponent, Mantissa)
    exponent1 <= operand1(30 downto 23);
    exponent2 <= operand2(30 downto 23);
    mantissa1 <= operand1(22 downto 0);
    mantissa2 <= operand2(22 downto 0);

    
    -- Multiply numbers
    alu_block: alu_multiply port map(
            mantissa_1      => mantissa1,
            mantissa_2      => mantissa2,
            exponent_1      => exponent1,
            exponent_2      => exponent2,
            s1              => operand1(31),
            s2              => operand2(31),
            result_sign     => final_sign,
            result_exponent => result_exponent,
            result_mantissa => result_mantissa
     );
     
     
     -- Normalize result if needed
     normalize_block: normalize port map(
        mantissa            => result_mantissa,
        exponent            => result_exponent,
        mantissa_normalized => normalized_mantissa,
        exponent_normalized => final_exponent
    );
    
    
     round_block: round_result port map(
        mantissa_in  => normalized_mantissa,
        mantissa_out => final_mantissa
    );
    
    first_number <= operand1;
    second_number <= operand2;
    result_out <= final_sign & final_exponent & final_mantissa;

end Behavioral;
