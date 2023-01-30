#include <stdio.h>

int main(void)
{
	uint32_t *regmap = (uint32_t *) 0x70000000; // base address of axi_regmap as set in the Vivado address editor

// CORNER CASES
	printf("\n------------CORNER CASES TESTING------------\n");

	//corner case 1
	printf("Corner case 1: A + B <= 2^31-1 (cout = 0)\n");
	size_t i = 10, j = 20;
	regmap[0] = i;         // write to register 0 (REG0_OUT, input A of adder)
	regmap[1] = j;         // write to register 1 (REG1_OUT, input B of adder)
	regmap[2] = 0;		   // write to register 2 (REG2_OUT, input K of adder)
	size_t r  = regmap[0]; // read from register 0 (REG0_IN, output S of adder)
	size_t cout = regmap[2]; // read from register 2 (REG2_IN, output cout of adder)
	printf("%2zu + %2zu = %3zu, (%s) , cout = %3zu, (%s)\n", i, j, r, (r <= 4294967295) ? "COR" : "ERR", cout, (cout == 0) ? "COR" : "ERR");

	//corner case 2
	printf("\nCorner case 2: A + B > 2^31-1 (cout = 1)\n");
	i = 4294967295, j = 1;		// i = 0xFFFFFFFF
	regmap[0] = i;
	regmap[1] = j;
	regmap[2] = 0;
	r  = regmap[0];
	cout = regmap[2];
	printf("%2zu + %2zu = %3zu, (%s) , cout = %3zu, (%s)\n", i, j, r, (r == 0) ? "COR" : "ERR", cout, (cout == 1) ? "COR" : "ERR");

	//corner case 3
	printf("\nCorner case 3: A - B > 0 (cout = 1)\n");
	i = 3, j = 2;		// i = 0xFFFFFFFF, j = 0xEEEEEEEE
	regmap[0] = i;
	regmap[1] = j;
	regmap[2] = 1;
	r  = regmap[0];
	cout = regmap[2];
	printf("%2zu - %2zu = %3zu, (%s) , cout = %3zu, (%s)\n", i, j, r, (r > 0) ? "COR" : "ERR", cout, (cout == 1) ? "COR" : "ERR");

	//corner case 4
	printf("\nCorner case 4: A - B = 0 (cout = 1)\n");
	i = -2147483648, j = -2147483648;		// i = 0x80000000, j = 0x80000000
	regmap[0] = i;
	regmap[1] = j;
	regmap[2] = 1;
	r  = regmap[0];
	cout = regmap[2];
	printf("%2zu - %2zu = %3zu, (%s) , cout = %3zu, (%s)\n", i, j, r, (r == 0) ? "COR" : "ERR", cout, (cout == 1) ? "COR" : "ERR");

	//corner case 5
	printf("\nCorner case 5: A - B < 0 (cout = 0)\n");
	i = -2147483648, j = -1;		// i = 0xEEEEEEEE, j = 0xFFFFFFFF
	regmap[0] = i;
	regmap[1] = j;
	regmap[2] = 1;
	r  = regmap[0];
	cout = regmap[2];
	printf("%2zu - %2zu = %3zu, (%s) , cout = %3zu, (%s)\n", i, j, r, (r > 0) ? "COR" : "ERR", cout, (cout == 1) ? "COR" : "ERR");


//	RANDOM TESTING

	// Random Test 1
	printf("\nRandom test 1\n");
	i = 35, j = 15;
	regmap[0] = i;
	regmap[1] = j;
	regmap[2] = 0;
	r  = regmap[0];
	cout = regmap[2];
	printf("%2zu + %2zu = %3zu, (%s) , cout = %3zu, (%s)\n", i, j, r, (r == 50) ? "COR" : "ERR", cout, (cout == 0) ? "COR" : "ERR");

	// Random Test 2
	printf("\nRandom test 2\n");
	i = 70, j = 35;
	regmap[0] = i;
	regmap[1] = j;
	regmap[2] = 1;
	r  = regmap[0];
	cout = regmap[2];
	printf("%2zu - %2zu = %3zu, (%s) , cout = %3zu, (%s)\n", i, j, r, (r == 35) ? "COR" : "ERR", cout, (cout == 0) ? "COR" : "ERR");

	// Random Test 3
	printf("\nRandom test 3\n");
	i = 0, j = 15;
	regmap[0] = i;
	regmap[1] = j;
	regmap[2] = 1;
	r  = regmap[0];
	cout = regmap[2];
	printf("%2zu + %2zu = %3zu, (%s) , cout = %3zu, (%s)\n", i, j, r, (r == -15) ? "COR" : "ERR", cout, (cout == 1) ? "COR" : "ERR");
	return 0;
}
