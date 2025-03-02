library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fp_top_level is
  Port (
        op      : in std_logic;
        reset   : in std_logic;
        anod    : out std_logic_vector(3 downto 0);
        catod   : out std_logic_vector(7 downto 0);
        result  : out std_logic_vector(31 downto 0)
       );
end fp_top_level;

architecture Behavioral of fp_top_level is

    component add_top_level is
        Port (
         first_number    : out std_logic_vector(31 downto 0);
         second_number    : out std_logic_vector(31 downto 0);
         result_out    : out std_logic_vector(31 downto 0)            );
    end component;

    component multiply_top_level is
      Port (
        first_number  : out std_logic_vector(31 downto 0);
        second_number : out std_logic_vector(31 downto 0);
        result_out    : out std_logic_vector(31 downto 0) -- Final floating-point result
        );
    end component;
    
    component floating_point_to_binary is
        Port ( 
                number_in : in std_logic_vector(31 downto 0);
                number_out : out std_logic_vector(31 downto 0)
          );
    end component;
    
    component ssd is
         Port ( 
             number : in std_logic_vector(31 downto 0);
             anod : out std_logic_vector (3 downto 0);
             catod : out std_logic_vector (7 downto 0)
          );
    end component;
    
    signal first_number     : std_logic_vector(31 downto 0);
    signal second_number    : std_logic_vector(31 downto 0);
    
    signal result_add       : std_logic_vector(31 downto 0);
    signal result_multiply  : std_logic_vector(31 downto 0);
    
    signal chosen_result    : std_logic_vector(31 downto 0);
    signal op_result        : std_logic_vector(31 downto 0);

    
 begin

    --choose operation depending on op -> 0 add, 1 multiply
    process(op, reset)
    begin
        
        if reset = '1' then
            chosen_result <= (others => '0');
        else
            if op = '0' then
                chosen_result <= result_add;
            else
                chosen_result <= result_multiply;
            end if;
         
        end if;
    end process;
    
    add: add_top_level port map(
        first_number  => first_number,
        second_number => second_number,
        result_out    => result_add
    );
    
    multiply: multiply_top_level port map(
        first_number  => first_number,
        second_number => second_number,
        result_out  => result_multiply
    );
    
--    convert: floating_point_to_binary port map(
--        number_in   => chosen_result,
--        number_out  => op_result
--    );
    
--    display: ssd port map(
--        number  => op_result,
--        anod    => anod,
--        catod   => catod
--    );
    
    result <= chosen_result;

end architecture;