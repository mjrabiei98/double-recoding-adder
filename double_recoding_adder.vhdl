LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY hz IS
    -- z {-2,-1,0} h {0,1}
    PORT (
        xi, yi : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        h : OUT STD_LOGIC;
        z : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY hz;

ARCHITECTURE behavioral OF hz IS
BEGIN
    PROCESS (xi, yi)
        VARIABLE temp_sum : STD_LOGIC_VECTOR(1 DOWNTO 0);
    BEGIN
        temp_sum := STD_LOGIC_VECTOR(signed(xi) + signed(yi));
        IF temp_sum = "00" THEN
            h <= '0';
            z <= "00";
        ELSIF temp_sum = "01" THEN
            h <= '1';
            z <= "11";
        ELSIF temp_sum = "10" THEN
            h <= '0';
            z <= "10";
        ELSIF temp_sum = "11" THEN
            h <= '0';
            z <= "10";
        else
            h <= '1';
            z <= "00";
        END IF;

    END PROCESS;
END behavioral; -- behavioral

-- ENTITY adder IS
--     -- q {-2,-1,0,1}
--     PORT (
--         h : IN STD_LOGIC;
--         z : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
--         q : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
-- END ENTITY adder;

-- ARCHITECTURE behavioral OF adder IS

--     SIGNAL

-- BEGIN

-- END behavioral; -- behavioral
-- ENTITY tw IS
--     -- q {-2,-1,0,1}
--     PORT (
--         h : IN STD_LOGIC;
--         z : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
--         q : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
-- END ENTITY tw;

-- ARCHITECTURE behavioral OF tw IS

--     SIGNAL

-- BEGIN

-- END behavioral; -- behavioral