LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE work.mypackage.ALL;

ENTITY testbench IS END ENTITY;
ARCHITECTURE behavioral OF testbench IS
    SIGNAL xx1 : sd_array (3 DOWNTO 0);
    SIGNAL yy1 : sd_array (3 DOWNTO 0);
    SIGNAL ss1 : sd_array (3 DOWNTO 0);
BEGIN
    UUT : ENTITY work.Signed_digit GENERIC MAP(4) PORT MAP(xx1, yy1, ss1, cc1);
    PROCESS BEGIN
        xx1(0) <= "00";
        xx1(1) <= "01";
        xx1(2) <= "01";
        xx1(3) <= "00";
        yy1(0) <= "00";
        yy1(1) <= "11";
        yy1(2) <= "01";
        yy1(3) <= "01";
        WAIT FOR 50 NS;
        xx1(0) <= "00";
        xx1(1) <= "01";
        xx1(2) <= "00";
        xx1(3) <= "11";
        yy1(0) <= "00";
        yy1(1) <= "01";
        yy1(2) <= "00";
        yy1(3) <= "01";
        wait for 50 ns;
        std.env.stop; -- or std.env.stop;
    END PROCESS;
END ARCHITECTURE behavioral;