library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fp_register_file is
    Port (
        read_address : in std_logic_vector(1 downto 0);  -- Address for reading (2 bits for 4 registers)
        data_out : out std_logic_vector(31 downto 0)     -- Output data (32-bit floating-point)
    );
end fp_register_file;

architecture Behavioral of fp_register_file is
    -- Define a memory array to hold 4 floating-point numbers (32 bits each)
    type reg_array is array (0 to 3) of std_logic_vector(31 downto 0);

    -- Initialize registers with specific IEEE 754 floating-point values
    signal registers : reg_array := (
        "00111110010011001100110011001101",  -- 0.2 in IEEE 754
        "00111111110000000000000000000000",  -- 1.5 in IEEE 754
        
        --"01000001000000011001100110011010",    -- 8.1 in IEEE 754
        --"00111111110110011001100110011010",    --1.7 in IEEE 754
        
        --"01000001001010110101110000101001",    --10.71 in IEEE 754
        --"01000000000100111101011100001010",    --2.31 in IEEE 754
        
        "01000000111000110011001100110011",    -- 7.1 in IEEE 754
        "01000000000011001100110011001101"    -- 2.2 in IEEE 754
        
        --"01000000000100110011001100110011",     -- 2.3 in IEEE 754
        --"01000000010011001100110011001101"      -- 3.2 in IEEE 754
        
        --"01000000011001100110011001100110",        -- 3.6 in IEEE 754
        --"01000000100000110011001100110011"         -- 4.1 in IEEE 754
        
    );
begin
    -- Assign the output to the data at the specified read address
    data_out <= registers(to_integer(unsigned(read_address)));

end Behavioral;
