library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity cla_adder is
	port( 	a: in STD_LOGIC_VECTOR(3 downto 0);
		b: in STD_LOGIC_VECTOR(3 downto 0);
		c_in: in STD_LOGIC;
		sum: out STD_LOGIC_VECTOR(3 downto 0);
		c_out: out STD_LOGIC
	);
end entity cla_adder;

architecture bhv of cla_adder is
	signal g: STD_LOGIC_VECTOR(2 downto 0); --carry generate (only bits 0-2 generate)
	signal p: STD_LOGIC_VECTOR(3 downto 0); --carry propagate (only 0-2 propagate but p(3) used for sum
	signal c: STD_LOGIC_VECTOR(2 downto 0); --carry-in computation: c(0) is carry in for 1st bit and so on
begin
	g <= a(2 downto 0) and b(2 downto 0);
	p <= a xor b;
	--carry in for 0th bit is c_in
	c(0) <= g(0) or (p(0) and c_in); --carry in for 1st bit
	c(1) <= g(1) or (p(1) and g(0)) or (p(1) and p(0) and c_in); --carry in for 2nd bit
	c(2) <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or (p(2) and p(1) and p(0) and c_in); --carry in for 3rd bit
	sum <= p xor (c & c_in); --concatenates to form whole carry-in vector for sum computation
	c_out <= ((a(3) xor b(3)) and c(2)) or (a(3) and b(3)); --carry-out only calculated for 3rd bit (overflow)
end bhv;
