library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity add_top_level is
    Port (
         first_number    : out std_logic_vector(31 downto 0);
         second_number    : out std_logic_vector(31 downto 0);
         result_out    : out std_logic_vector(31 downto 0) -- Final floating-point result
       );
end add_top_level;

architecture Behavioral of add_top_level is

    -- Component Declarations
    component fp_register_file
        Port (
            read_address : in std_logic_vector(1 downto 0);
            data_out     : out std_logic_vector(31 downto 0)
        );
    end component;

    component compare_exponents
      Port (exponent1 : in std_logic_vector(7 downto 0);
        exponent2 : in std_logic_vector(7 downto 0);
        diff : out std_logic_vector (7 downto 0);
        less : out std_logic;
        equal : out std_logic;
        greater : out std_logic
        );
    end component;

    component right_shift is
      Port (mantissa : in std_logic_vector(22 downto 0);
            shift_amount : in std_logic_vector(7 downto 0);
            mantissa_out : out std_logic_vector(23 downto 0)
            );
    end component;

    component alu
       Port (mantissa_1 : in std_logic_vector(22 downto 0);
        mantissa_2 : in std_logic_vector(23 downto 0);
        s1 : in std_logic;
        s2 : in std_logic;
        result_sign : out std_logic;
        result_mantissa : out std_logic_vector(23 downto 0)
        );
    end component;

    component normalize
        Port (
            mantissa            : in std_logic_vector(23 downto 0);
            exponent            : in std_logic_vector(7 downto 0);
            mantissa_normalized : out std_logic_vector(22 downto 0);
            exponent_normalized : out std_logic_vector(7 downto 0)
        );
    end component;

    component round_result
        Port (
            mantissa_in  : in std_logic_vector(22 downto 0);
            mantissa_out : out std_logic_vector(22 downto 0)
        );
    end component;

    -- Signals
    signal operand1, operand2          : std_logic_vector(31 downto 0);
    signal exponent1, exponent2        : std_logic_vector(7 downto 0);
    signal mantissa1, mantissa2        : std_logic_vector(22 downto 0);
    
    signal shift_amount                : std_logic_vector(7 downto 0);
    signal less, equal, greater        : std_logic;
    
    signal mantissa_to_shift, mantissa_not_to_shift : std_logic_vector (22 downto 0)  := (others => '0');
    signal mantissa_shifted : std_logic_vector (23 downto 0) := (others => '0');
    signal final_mantissa : std_logic_vector (22 downto 0) := (others => '0');
    signal exponent_greater : std_logic_vector (7 downto 0)  := (others => '0');

    
    signal aligned_mantissa1, aligned_mantissa2 : std_logic_vector(22 downto 0) := (others => '0');
    signal normalized_mantissa         : std_logic_vector(22 downto 0) := (others => '0');
    signal normalized_exponent         : std_logic_vector(7 downto 0)  := (others => '0');
    signal result_sign                 : std_logic;
    signal result_mantissa             : std_logic_vector (23 downto 0) := (others => '0');
    signal final_result                : std_logic_vector(31 downto 0) := (others => '0');


begin

    -- Register File to Fetch Operands
    fp_register_1: fp_register_file port map(
        read_address => "00",
        data_out     => operand1
    );

    fp_register_2: fp_register_file port map(
        read_address => "01",
        data_out     => operand2
    );
    

    -- Extract Fields (Sign, Exponent, Mantissa)
    exponent1 <= operand1(30 downto 23);
    exponent2 <= operand2(30 downto 23);
    mantissa1 <= operand1(22 downto 0);
    mantissa2 <= operand2(22 downto 0);

     -- Exponent Comparison
    compare_exp: compare_exponents port map(
        exponent1       => exponent1,
        exponent2       => exponent2,
        diff            => shift_amount,
        less            => less,
        equal           => equal,
        greater         => greater
    );
    
     
    with less select
        mantissa_to_shift <= mantissa1 when '1',
                            mantissa2 when others;

    with less select
        mantissa_not_to_shift <= mantissa2 when '1',
                                 mantissa1 when others;
    
    with less select
        exponent_greater <= exponent2 when '1',
                            exponent1 when others;

     
    allign: right_shift port map (
        mantissa        => mantissa_to_shift,
        shift_amount    => shift_amount,
        mantissa_out    => mantissa_shifted
    );

     alu_block: alu port map(
        mantissa_1      => mantissa_not_to_shift,
        mantissa_2      => mantissa_shifted,
        s1              => operand1(31),
        s2              => operand2(31),
        result_sign     => result_sign,
        result_mantissa => result_mantissa
    );
    
    
     normalize_block: normalize port map(
        mantissa            => result_mantissa,
        exponent            => exponent_greater,
        mantissa_normalized => normalized_mantissa,
        exponent_normalized => normalized_exponent
    );
    
    
     round_block: round_result port map(
        mantissa_in  => normalized_mantissa,
        mantissa_out => final_mantissa
    );

    first_number <= operand1;
    second_number <= operand2;
    result_out <= result_sign & normalized_exponent & final_mantissa;


end Behavioral;
