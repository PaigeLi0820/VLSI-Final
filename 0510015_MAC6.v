//VLSI Final Project 
//0510015
/*
ncverilog +access+r TESTBED.v      -      test your design 
ncverilog MAC6.v          -      compile your design 
*/
`include "GATE_LIB.v"
module MAC6 (//input
             A,
             B,
             MODE,
             ACC,
             //output
             OUT);
	input  [5:0]  A,B;
	input  [11:0] ACC;
	input  [1:0]  MODE;
	output [12:0] OUT;

	///// Write your design here /////
	wire [12-1:0] AB;
	Multiplier	M1(A, B, AB);
	//send 13bit A, B, ACC into MAC_Block
	MAC_Block	M2({A[5], A[5], A[5], A[5], A[5], A[5], A[5], A}, 
					{B[5], B[5], B[5], B[5], B[5], B[5], B[5], B},
					{AB[11], AB},
					{ACC[11], ACC}, MODE, OUT);

endmodule

///// Write your design (other modules) here /////
//1 bit PLA adder
module FA(A, B, Cin, Sum, Cout);
	input A, B, Cin;
	output Sum, Cout;
	wire A_inv, B_inv, C_inv;
	wire b_c, a_c, a_b, a_b_c, av_bv_c, av_b_cv, a_bv_cv;
	
	VLSI_NOT N1(.OUT(A_inv), .IN(A));
	VLSI_NOT N2(.OUT(B_inv), .IN(B));
	VLSI_NOT N3(.OUT(C_inv), .IN(Cin));
	//
	VLSI_NAND2	A1(.OUT(b_c), .INA(B), .INB(Cin));
	VLSI_NAND2	A2(.OUT(a_c), .INA(A), .INB(Cin));
	VLSI_NAND2	A3(.OUT(a_b), .INA(A), .INB(B));
	//
	VLSI_NAND3	A4(.OUT(  a_b_c), .INA(	   A), .INB(	B), .INC(Cin));
	VLSI_NAND3	A5(.OUT(av_bv_c), .INA(A_inv), .INB(B_inv), .INC(Cin));
	VLSI_NAND3	A6(.OUT(av_b_cv), .INA(A_inv), .INB(	B), .INC(C_inv));
	VLSI_NAND3	A7(.OUT(a_bv_cv), .INA(	   A), .INB(B_inv), .INC(C_inv));
	//
	VLSI_NAND3	A8(.OUT(Cout), .INA(b_c), .INB(a_c), .INC(a_b));
	VLSI_NAND4	A9(.OUT(Sum), .INA(a_b_c), .INB(av_bv_c), .INC(av_b_cv), .IND(a_bv_cv));
endmodule 

//1 bit half adder
module HA(A, B, Sum, Cout);
	input A, B;
	output Sum, Cout;
	
	VLSI_AND2 A1(.OUT(Cout), .INA(A), .INB(B));
	VLSI_XOR2 X1(.OUT(Sum), .INA(A), .INB(B));
endmodule

//BoothEncoder from Lab4
module BoothEncoder(x2i_m, x2i, x2i_p, Xi, Xi_2, Mi);
	input x2i_m;
	input x2i;
	input x2i_p;
	output Xi;
	output Xi_2;
	output Mi;
	
	assign Mi = x2i_p;
	wire x2i_inv, x2i_p_inv;
	wire nand1, nand2;
	VLSI_NOT	X1(.OUT(x2i_inv), .IN(x2i));
	VLSI_NOT	X2(.OUT(x2i_p_inv), .IN(x2i_p));
	VLSI_NOT	X3(.OUT(x2i_m_inv), .IN(x2i_m));
	
	VLSI_XOR2	X4(.OUT(Xi), .INA(x2i_m), .INB(x2i));
	VLSI_NAND3	X5(.OUT(nand1), .INA(x2i_m), .INB(x2i), .INC(x2i_p_inv));
	VLSI_NAND3	X6(.OUT(nand2), .INA(x2i_m_inv), .INB(x2i_inv), .INC(x2i_p));
	VLSI_NAND2	X7(.OUT(Xi_2), .INA(nand1), .INB(nand2));
endmodule

//BoothSelector from Lab4
module BoothSelection(yj, yj_1, Xi, Xi_2, Mi, ppij);
	input yj;
	input yj_1;
	input Xi;
	input Xi_2;
	input Mi;
	output ppij;
	
	wire n1, n2, n3;
	VLSI_NAND2	X1(.OUT(n1), .INA(yj), .INB(Xi));
	VLSI_NAND2	X2(.OUT(n2), .INA(yj_1), .INB(Xi_2));
	VLSI_NAND2	X3(.OUT(n3), .INA(n1), .INB(n2));
	VLSI_XOR2	X4(.OUT(ppij), .INA(n3), .INB(Mi));
endmodule

//BoothHardware: get partial product pp0, pp1, pp2
module BoothHardware(A, B, pp0, pp1, pp2);
	input [6-1:0]	A, B;
	output [7-1:0]	pp0, pp1, pp2;
	wire [3-1:0] 	X, X2, M;
	
	BoothEncoder B1({1'b0}, B[0], B[1], X[0], X2[0], M[0]);
	BoothSelection S01(A[0], {1'b0},X[0], X2[0], M[0], pp0[0]);
	BoothSelection S02(A[1], A[0],	X[0], X2[0], M[0], pp0[1]);
	BoothSelection S03(A[2], A[1],	X[0], X2[0], M[0], pp0[2]);
	BoothSelection S04(A[3], A[2],	X[0], X2[0], M[0], pp0[3]);
	BoothSelection S05(A[4], A[3],	X[0], X2[0], M[0], pp0[4]);
	BoothSelection S06(A[5], A[4],	X[0], X2[0], M[0], pp0[5]);
	BoothSelection S07(A[5], A[5],	X[0], X2[0], M[0], pp0[6]);
	//
	BoothEncoder B2(B[1], B[2], B[3], X[1], X2[1], M[1]);
	BoothSelection S08(A[0], {1'b0},X[1], X2[1], M[1], pp1[0]);
	BoothSelection S09(A[1], A[0],	X[1], X2[1], M[1], pp1[1]);
	BoothSelection S10(A[2], A[1],	X[1], X2[1], M[1], pp1[2]);
	BoothSelection S11(A[3], A[2],	X[1], X2[1], M[1], pp1[3]);
	BoothSelection S12(A[4], A[3],	X[1], X2[1], M[1], pp1[4]);
	BoothSelection S13(A[5], A[4],	X[1], X2[1], M[1], pp1[5]);
	BoothSelection S14(A[5], A[5],	X[1], X2[1], M[1], pp1[6]);
	//
	BoothEncoder B3(B[3], B[4], B[5], X[2], X2[2], M[2]);
	BoothSelection S15(A[0], {1'b0},X[2], X2[2], M[2], pp2[0]);
	BoothSelection S16(A[1], A[0],	X[2], X2[2], M[2], pp2[1]);
	BoothSelection S17(A[2], A[1],	X[2], X2[2], M[2], pp2[2]);
	BoothSelection S18(A[3], A[2],	X[2], X2[2], M[2], pp2[3]);
	BoothSelection S19(A[4], A[3],	X[2], X2[2], M[2], pp2[4]);
	BoothSelection S20(A[5], A[4],	X[2], X2[2], M[2], pp2[5]);
	BoothSelection S21(A[5], A[5],	X[2], X2[2], M[2], pp2[6]);
endmodule

//Wallace Tree: efficientway to add partial product
module Wallace_Tree(P, Q, R, P_hot_one, Q_hot_one, R_hot_one, OUT);
	input [7-1:0] P, Q, R;
	input P_hot_one, Q_hot_one, R_hot_one;
	output [12-1:0] OUT;
	//sum and carry for (P + Q + R + P_hot_one + Q_hot_one)
	wire [11-1:0]	Sum1, Cout1;
	//sum and carry for (Sum1, Cout1) + R_hot_one
	wire [12-1:0]	Sum2, Cout2;
	wire z;
	
	//first stage
	HA	A01(P[0], P_hot_one, Sum1[0], Cout1[0]);
	HA	A02(P[1], {1'b0}, Sum1[1], Cout1[1]);
	FA	A03(P[2], Q[0], Q_hot_one, Sum1[2], Cout1[2]);
	HA	A04(P[3], Q[1], Sum1[3], Cout1[3]);
	FA	A05(P[4], Q[2], R[0], Sum1[4], Cout1[4]);
	FA	A06(P[5], Q[3], R[1], Sum1[5], Cout1[5]);
	FA	A07(P[6], Q[4], R[2], Sum1[6], Cout1[6]);
	FA	A08(P[6], Q[5], R[3], Sum1[7], Cout1[7]);
	FA	A09(P[6], Q[6], R[4], Sum1[8], Cout1[8]);
	FA	A10(~P[6], ~Q[6], R[5], Sum1[9], Cout1[9]);
	HA	A11({1'b1}, R[6], Sum1[10], Cout1[10]);
	
	//second stage
	assign Sum2[0] = Sum1[0];
	assign Cout2[0] = 1'b0;
	HA	B1(Sum1[1], Cout1[0], Sum2[1], Cout2[1]);
	HA	B2(Sum1[2], Cout1[1], Sum2[2], Cout2[2]);
	HA	B3(Sum1[3], Cout1[2], Sum2[3], Cout2[3]);
	FA	B4(Sum1[4], Cout1[3], R_hot_one, Sum2[4], Cout2[4]);
	HA	B5(Sum1[5], Cout1[4], Sum2[5], Cout2[5]);
	HA	B6(Sum1[6], Cout1[5], Sum2[6], Cout2[6]);
	HA	B7(Sum1[7], Cout1[6], Sum2[7], Cout2[7]);
	HA	B8(Sum1[8], Cout1[7], Sum2[8], Cout2[8]); 
	HA	B9(Sum1[9], Cout1[8], Sum2[9], Cout2[9]);
	HA	B10(Sum1[10], Cout1[9], Sum2[10], Cout2[10]);
	HA	B11(~R[6], Cout1[10], Sum2[11], Cout2[11]); //Cout2[11] is useless
	//carry Lookahead Adder 12 bit: add Sum2 & Cout2
	//finally we get multiple answer!(12b output) 
	CLA_12b	A25(Sum2[11:0], {Cout2[10:0], 1'b0}, {1'b0}, OUT, z);
endmodule

//Multipler structure 
module Multiplier(A, B, AB);
	input [6-1:0]	A, B;
	output [12-1:0]	AB;
	wire [7-1:0] pp0, pp1, pp2;
	
	BoothHardware	B1(A, B, pp0, pp1, pp2);
	Wallace_Tree	W1(pp0, pp1, pp2, B[1], B[3], B[5], AB); 
endmodule

//Carry lookahead Adder 3-bit
module CLA_3b(A, B, Cin, Sum, Cout);
	input [3-1:0]	A, B;
	input Cin;
	output [3-1:0]	Sum;
	output Cout;
	
	wire [3-1:0]	P, G, G_inv;
	wire [2-1:0]	Carry;
	wire w0, w1, w2, w3, w4, w5;
	
	VLSI_XOR2	X1(.OUT(P[0]), .INA(A[0]), .INB(B[0]));
	VLSI_XOR2	X2(.OUT(P[1]), .INA(A[1]), .INB(B[1]));
	VLSI_XOR2	X3(.OUT(P[2]), .INA(A[2]), .INB(B[2]));
	
	VLSI_NAND2	A1(.OUT(G_inv[0]), .INA(A[0]), .INB(B[0]));
	VLSI_NAND2	A2(.OUT(G_inv[1]), .INA(A[1]), .INB(B[1]));
	VLSI_NAND2	A3(.OUT(G_inv[2]), .INA(A[2]), .INB(B[2]));
	
	VLSI_NOT	N1(.OUT(G[0]), .IN(G_inv[0]));
	VLSI_NOT	N2(.OUT(G[1]), .IN(G_inv[1]));
	VLSI_NOT	N3(.OUT(G[2]), .IN(G_inv[2]));
	
	VLSI_NAND2	A4(.OUT(w0), .INA(P[0]), .INB(Cin));
	VLSI_NAND2	A5(.OUT(Carry[0]), .INA(G_inv[0]), .INB(w0));
	
	VLSI_NAND2	A6(.OUT(w1), .INA(P[1]), .INB(G[0]));
	VLSI_NAND3	A7(.OUT(w2), .INA(P[1]), .INB(P[0]), .INC(Cin));
	VLSI_NAND3	A8(.OUT(Carry[1]), .INA(G_inv[1]), .INB(w1), .INC(w2));
	
	VLSI_NAND2	A9(.OUT(w3), .INA(P[2]), .INB(G[1]));
	VLSI_NAND3	A10(.OUT(w4), .INA(P[2]), .INB(P[1]), .INC(G[0]));
	VLSI_NAND4	A11(.OUT(w5), .INA(P[2]), .INB(P[1]), .INC(P[0]), .IND(Cin));
	VLSI_NAND4	A12(.OUT(Cout), .INA(G_inv[2]), .INB(w3), .INC(w4), .IND(w5));
	
	VLSI_XOR2	X4(.OUT(Sum[0]), .INA(P[0]), .INB(Cin));
	VLSI_XOR2	X5(.OUT(Sum[1]), .INA(P[1]), .INB(Carry[0]));
	VLSI_XOR2	X6(.OUT(Sum[2]), .INA(P[2]), .INB(Carry[1]));
endmodule

//12 bit adder constructed of 4*(3bit CLA)
module CLA_12b(A, B, Cin, Sum, Cout);
	input [12-1:0]	A, B;
	input Cin;
	output [12-1:0] Sum;
	output Cout;
	wire [3-1:0] Carry;
	
	CLA_3b	C1(A[2:0], 	B[2:0],		  Cin, Sum[2:0], Carry[0]);
	CLA_3b	C2(A[5:3],	B[5:3],	 Carry[0], Sum[5:3], Carry[1]);
	CLA_3b	C3(A[8:6], 	B[8:6],  Carry[1], Sum[8:6], Carry[2]);
	CLA_3b	C4(A[11:9], B[11:9], Carry[2], Sum[11:9], Cout);
endmodule

//13 bit adder constructed of 4*(3bit CLA) + 1b FA
module CLA_13b(A, B, Cin, Sum);
	input [13-1:0]	A, B;
	input Cin;
	output [13-1:0] Sum;
	wire [4-1:0] Carry;
	wire z;
	
	CLA_3b	C1(A[2:0], 	B[2:0],		  Cin, Sum[2:0], Carry[0]);
	CLA_3b	C2(A[5:3],	B[5:3],	 Carry[0], Sum[5:3], Carry[1]);
	CLA_3b	C3(A[8:6], 	B[8:6],  Carry[1], Sum[8:6], Carry[2]);
	CLA_3b	C4(A[11:9], B[11:9], Carry[2], Sum[11:9], Carry[3]);
	FA		F1(A[12], B[12], Carry[3], Sum[12], z); 
endmodule

module Invert_13b(A, A_v);
	input [13-1:0]	A;
	output [13-1:0] A_v;
	VLSI_NOT	N1(.OUT(A_v[0]), .IN(A[0]));
	VLSI_NOT	N2(.OUT(A_v[1]), .IN(A[1]));
	VLSI_NOT	N3(.OUT(A_v[2]), .IN(A[2]));
	VLSI_NOT	N4(.OUT(A_v[3]), .IN(A[3]));
	VLSI_NOT	N5(.OUT(A_v[4]), .IN(A[4]));
	VLSI_NOT	N6(.OUT(A_v[5]), .IN(A[5]));
	VLSI_NOT	N7(.OUT(A_v[6]), .IN(A[6]));
	VLSI_NOT	N8(.OUT(A_v[7]), .IN(A[7]));
	VLSI_NOT	N9(.OUT(A_v[8]), .IN(A[8]));
	VLSI_NOT	N10(.OUT(A_v[9]), .IN(A[9]));
	VLSI_NOT	N11(.OUT(A_v[10]), .IN(A[10]));
	VLSI_NOT	N12(.OUT(A_v[11]), .IN(A[11]));
	VLSI_NOT	N13(.OUT(A_v[12]), .IN(A[12]));
endmodule

//2 to 1 mutiplexer, 0:select A, 1:select B
module MUX2_1b(A, B, MODE, OUT);
	input A, B;
	input MODE;
	output OUT;
	wire MODE_inv;
	wire w1, w2;
	
	VLSI_NOT	N1(.OUT(MODE_inv), .IN(MODE));
	VLSI_NAND2	N2(.OUT(w1), .INA(A), .INB(MODE_inv));
	VLSI_NAND2	N3(.OUT(w2), .INA(B), .INB(MODE));
	VLSI_NAND2	N4(.OUT(OUT), .INA(w1), .INB(w2));
endmodule

//construct 13-bit MUX by 13*(1bit MUX)
module MUX2_13b(A, B, MODE, OUT);
	input [13-1:0] A, B;
	input MODE;
	output [13-1:0] OUT;
	
	MUX2_1b	M1(A[0], B[0], MODE, OUT[0]);
	MUX2_1b	M2(A[1], B[1], MODE, OUT[1]);
	MUX2_1b	M3(A[2], B[2], MODE, OUT[2]);
	MUX2_1b	M4(A[3], B[3], MODE, OUT[3]);
	MUX2_1b	M5(A[4], B[4], MODE, OUT[4]);
	MUX2_1b	M6(A[5], B[5], MODE, OUT[5]);
	MUX2_1b	M7(A[6], B[6], MODE, OUT[6]);
	MUX2_1b	M8(A[7], B[7], MODE, OUT[7]);
	MUX2_1b	M9(A[8], B[8], MODE, OUT[8]);
	MUX2_1b	M10(A[9], B[9], MODE, OUT[9]);
	MUX2_1b	M11(A[10], B[10], MODE, OUT[10]);
	MUX2_1b	M12(A[11], B[11], MODE, OUT[11]);
	MUX2_1b	M13(A[12], B[12], MODE, OUT[12]);
endmodule

module MAC_Block(A, B, AB, ACC, MODE, OUT);
	input [13-1:0]	A, B, ACC;
	input [13-1:0]	AB;
	input [1:0] 	MODE;
	output [13-1:0]	OUT;
	
	wire [13-1:0]	add1, add2, add2_sel;
	wire [13-1:0]	add2_inv;
	wire Cin;
	//select add1 as A*B or A
	MUX2_13b	M1(AB, A, MODE[1], add1);
	//selct ACC or B
	MUX2_13b	M2(ACC, B, MODE[1], add2);
	//invert add2
	Invert_13b	I1(add2, add2_inv);
	//select sign
	MUX2_13b	M3(add2, add2_inv, MODE[0], add2_sel);
	MUX2_1b		M4({1'b0}, {1'b1}, MODE[0], Cin);
	//add add1 & add2_sel together, get the final answer!
	CLA_13b		C1(add1, add2_sel, Cin, OUT);
endmodule