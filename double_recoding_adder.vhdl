LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY hz IS
    -- z {-2,-1,0} h {0,1}
    PORT (
        xi, yi : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        h : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
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
            h <= "00";
            z <= "00";
        ELSIF temp_sum = "01" THEN
            h <= "01";
            z <= "11";
        ELSIF temp_sum = "10" THEN
            h <= "00";
            z <= "10";
        ELSIF temp_sum = "11" THEN
            h <= "00";
            z <= "10";
        ELSE
            h <= "01";
            z <= "00";
        END IF;

    END PROCESS;
END behavioral; -- behavioral

-------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY adder IS
    -- q {-2,-1,0,1}
    PORT (
        a : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        b : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END ENTITY adder;

ARCHITECTURE behavioral OF adder IS
BEGIN
    q <= STD_LOGIC_VECTOR(signed(a) + signed(b));
END behavioral; -- behavioral

------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY tw IS
    -- q {-2,-1,0,1}
    PORT (
        q : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        t : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        w : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY tw;

ARCHITECTURE behavioral OF tw IS
BEGIN

    PROCESS (q) BEGIN

        IF q = "00" THEN
            w <= "00";
            t <= "00";
        ELSIF q = "01" THEN
            w <= "01";
            t <= "00";
        ELSIF q = "11" THEN
            w <= "01";
            t <= "11";
        ELSIF q = "10" THEN
            w <= "00";
            t <= "11";
        ELSE
            w <= "00";
            t <= "00";
        END IF;

    END PROCESS;

END behavioral; -- behavioral
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE mypackage IS
    TYPE sd_array IS ARRAY (NATURAL RANGE <>) OF STD_LOGIC_VECTOR(1 DOWNTO 0);
    TYPE d_array IS ARRAY (NATURAL RANGE <>) OF STD_LOGIC;
END;

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.mypackage.ALL;

ENTITY double_recoding_adder IS
    GENERIC (input_size : INTEGER := 16);
    PORT (
        x, y : IN sd_array (input_size - 1 DOWNTO 0);
        sum : OUT sd_array (input_size - 1 DOWNTO 0)
    );
END ENTITY double_recoding_adder;
ARCHITECTURE behavioral OF double_recoding_adder IS

    SIGNAL h : sd_array (input_size DOWNTO 0);
    SIGNAL z : sd_array (input_size - 1 DOWNTO 0);
    SIGNAL t : sd_array (input_size DOWNTO 0);
    SIGNAL w : sd_array (input_size - 1 DOWNTO 0);
    SIGNAL q : sd_array (input_size - 1 DOWNTO 0);

BEGIN
    h(0) <= "00";
    t(0) <= "00";
    u : FOR i IN 0 TO input_size - 1 GENERATE
    BEGIN
        hzi : ENTITY work.hz(behavioral) PORT MAP(xi => x(i), yi => y(i), H => h(i + 1), Z => z(i));
        adder1_i : ENTITY work.Adder(behavioral) PORT MAP(a => z(i), b => h(i), q => q(i));
        twi : ENTITY work.TW(behavioral) PORT MAP(Q => q(i), w => w(i), t => t(i + 1));
        adder2_i : ENTITY work.Adder(behavioral) PORT MAP(a => t(i), b => w(i), q => sum(i));
    END GENERATE;

END behavioral;