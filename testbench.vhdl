LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE work.mypackage.ALL;

ENTITY testbench IS END ENTITY;
ARCHITECTURE behavioral OF testbench IS
    SIGNAL x : sd_array (3 DOWNTO 0);
    SIGNAL y : sd_array (3 DOWNTO 0);
    SIGNAL s : sd_array (3 DOWNTO 0);
BEGIN
    UUT : ENTITY work.double_recoding_adder(behavioral)
        GENERIC MAP(4)
        PORT MAP(x, y, s);
    PROCESS BEGIN
        x(0) <= "00";
        x(1) <= "01";
        x(2) <= "01";
        x(3) <= "00";
        y(0) <= "00";
        y(1) <= "11";
        y(2) <= "01";
        y(3) <= "01";
        WAIT FOR 50 NS;
        x(0) <= "00";
        x(1) <= "01";
        x(2) <= "00";
        x(3) <= "11";
        y(0) <= "00";
        y(1) <= "01";
        y(2) <= "00";
        y(3) <= "01";
        WAIT FOR 50 ns;
        std.env.stop; -- or std.env.stop;
    END PROCESS;
END ARCHITECTURE behavioral;