****  Final Project :Two stage pipeline Four mode 6-bit MAC  ***

*************************************************************
*************************************************************
***************Don't touch settings below********************
*************************************************************
*************************************************************
.lib "umc018.l" L18U18V_TT 
.vec 'MAC6.vec'

.temp 25
.op
.options brief post

***************** parameter ****************************
.global  VDD  GND
.param supply = 1.8v
.param load = 10f
.param tr = 0.2n

***************** voltage source ****************************
Vclk CLK GND pulse(0 supply 0 0.1ns 0.1ns "1*period/2-tr" "period*1")
Vd1 VDD GND supply

***************** top-circuit ****************************
XMAC6  CLK A[5] A[4] A[3] A[2] A[1] A[0]
+ B[5] B[4] B[3] B[2] B[1] B[0] 
+ MODE[1] MODE[0] 
+ ACC[11] ACC[10] ACC[9]  ACC[8] ACC[7] ACC[6] ACC[5] ACC[4] ACC[3] ACC[2] ACC[1] ACC[0]
+ OUT[12] OUT[11] OUT[10] OUT[9] OUT[8] OUT[7] OUT[6] OUT[5] OUT[4] OUT[3] OUT[2] OUT[1] OUT[0] MAC6
     
CLOAD01 OUT[0] GND load
CLOAD02 OUT[1] GND load 
CLOAD03 OUT[2] GND load 
CLOAD04 OUT[3] GND load 
CLOAD05 OUT[4] GND load 
CLOAD06 OUT[5] GND load 
CLOAD07 OUT[6] GND load 
CLOAD08 OUT[7] GND load 
CLOAD09 OUT[8] GND load 
CLOAD10 OUT[9] GND load 
CLOAD11 OUT[10] GND load 
CLOAD12 OUT[11] GND load 
CLOAD13 OUT[12] GND load  

***************** Average Power ****************************
.meas tran Iavg avg I(Vd1) from=0ns to='100*period'
.meas Pavg param='abs(Iavg)*supply'

*.tran 0.1n '1000*period'
.tran 0.1n '55*period'

*************************************************************
*************************************************************
***************Don't touch settings above********************
*************************************************************
*************************************************************

***** you can modify clock cycle here, remember synchronize with clock cycle in MAC6.vec ****
.param period = 2.35n

***** Define your sub-circuit and self-defined parameter here , and only need to submmit this part ****
.param wp=1.3u, wn=0.6u

.subckt MAC6 CLK A[5] A[4] A[3] A[2] A[1] A[0]
+ B[5] B[4] B[3] B[2] B[1] B[0] 
+ MODE[1] MODE[0] 
+ ACC[11] ACC[10] ACC[9]  ACC[8] ACC[7] ACC[6] 
+ ACC[5] ACC[4] ACC[3] ACC[2] ACC[1] ACC[0]
+ OUT[12] OUT[11] OUT[10] OUT[9] OUT[8] OUT[7] 
+ OUT[6] OUT[5] OUT[4] OUT[3] OUT[2] OUT[1] OUT[0]

*Delay of CLK
*In order to synchronize CLK_IN and CLK_v, we delay positive CLK
*Due to heavy clk loading, we use parallel connection
mp01 	CLK		GND CLK_IN  VDD P_18_G2 w=wp l=0.18u
mp02 	CLK		GND CLK_IN  VDD P_18_G2 w=wp l=0.18u 
mp03 	CLK		GND CLK_IN  VDD P_18_G2 w=wp l=0.18u 
mp04 	CLK		GND CLK_IN  VDD P_18_G2 w=wp l=0.18u 
mp05 	CLK		GND CLK_IN  VDD P_18_G2 w=wp l=0.18u 
mp06 	CLK		GND CLK_IN  VDD P_18_G2 w=wp l=0.18u 
mp07 	CLK		GND CLK_IN  VDD P_18_G2 w=wp l=0.18u 
mp08 	CLK		GND CLK_IN  VDD P_18_G2 w=wp l=0.18u 
mp09 	CLK		GND CLK_IN  VDD P_18_G2 w=wp l=0.18u 
mp10 	CLK		GND CLK_IN  VDD P_18_G2 w=wp l=0.18u 
mp11 	CLK		GND CLK_IN  VDD P_18_G2 w=wp l=0.18u
mp12 	CLK		GND CLK_IN  VDD P_18_G2 w=wp l=0.18u

mn01 CLK_IN	VDD	CLK		GND	N_18_G2 w=wn l=0.18u
mn02 CLK_IN	VDD	CLK		GND	N_18_G2 w=wn l=0.18u
mn03 CLK_IN	VDD	CLK		GND	N_18_G2 w=wn l=0.18u
mn04 CLK_IN	VDD	CLK		GND	N_18_G2 w=wn l=0.18u
mn05 CLK_IN	VDD	CLK		GND	N_18_G2 w=wn l=0.18u
mn06 CLK_IN	VDD	CLK		GND	N_18_G2 w=wn l=0.18u
mn07 CLK_IN	VDD	CLK		GND	N_18_G2 w=wn l=0.18u
mn08 CLK_IN	VDD	CLK		GND	N_18_G2 w=wn l=0.18u
mn09 CLK_IN	VDD	CLK		GND	N_18_G2 w=wn l=0.18u
mn10 CLK_IN	VDD	CLK		GND	N_18_G2 w=wn l=0.18u
mn11 CLK_IN	VDD	CLK		GND	N_18_G2 w=wn l=0.18u
mn12 CLK_IN	VDD	CLK		GND	N_18_G2 w=wn l=0.18u

Xinv_p01 CLK	CLK_v	INV
Xinv_p02 CLK	CLK_v	INV
Xinv_p03 CLK	CLK_v	INV
Xinv_p04 CLK	CLK_v	INV
Xinv_p05 CLK	CLK_v	INV
Xinv_p06 CLK	CLK_v	INV
Xinv_p07 CLK	CLK_v	INV
Xinv_p08 CLK	CLK_v	INV
Xinv_p09 CLK	CLK_v	INV
Xinv_p10 CLK	CLK_v	INV
Xinv_p11 CLK	CLK_v	INV
Xinv_p12 CLK	CLK_v	INV
*CLk definition end

*all input enters D-flip flop for the first stage
Xdff01 CLK_IN CLK_v A[5] A_d[5] DFF
Xdff02 CLK_IN CLK_v A[4] A_d[4] DFF
Xdff03 CLK_IN CLK_v A[3] A_d[3] DFF
Xdff04 CLK_IN CLK_v A[2] A_d[2] DFF
Xdff05 CLK_IN CLK_v A[1] A_d[1] DFF
Xdff06 CLK_IN CLK_v A[0] A_d[0] DFF

Xdff07 CLK_IN CLK_v B[5] B_d[5] DFF
Xdff08 CLK_IN CLK_v B[4] B_d[4] DFF
Xdff09 CLK_IN CLK_v B[3] B_d[3] DFF
Xdff10 CLK_IN CLK_v B[2] B_d[2] DFF
Xdff11 CLK_IN CLK_v B[1] B_d[1] DFF
Xdff12 CLK_IN CLK_v B[0] B_d[0] DFF

Xdff13 CLK_IN CLK_v ACC[11] ACC_d[11] DFF
Xdff14 CLK_IN CLK_v ACC[10] ACC_d[10] DFF
Xdff15 CLK_IN CLK_v ACC[9]	ACC_d[9] DFF
Xdff16 CLK_IN CLK_v ACC[8]	ACC_d[8] DFF
Xdff17 CLK_IN CLK_v ACC[7]	ACC_d[7] DFF
Xdff18 CLK_IN CLK_v ACC[6]	ACC_d[6] DFF
Xdff19 CLK_IN CLK_v ACC[5]	ACC_d[5] DFF
Xdff20 CLK_IN CLK_v ACC[4]	ACC_d[4] DFF
Xdff21 CLK_IN CLK_v ACC[3]	ACC_d[3] DFF
Xdff22 CLK_IN CLK_v ACC[2]	ACC_d[2] DFF
Xdff23 CLK_IN CLK_v ACC[1]	ACC_d[1] DFF
Xdff24 CLK_IN CLK_v ACC[0]	ACC_d[0] DFF

Xdff25 CLK_IN CLK_v MODE[1] MODE_d[1] DFF
Xdff26 CLK_IN CLK_v MODE[0] MODE_d[0] DFF
*end of DFF

*PartialProduct Calculation
Xpp A_d[5] A_d[4] A_d[3] A_d[2] A_d[1] A_d[0]
+ B_d[5] B_d[4] B_d[3] B_d[2] B_d[1] B_d[0] 
+ pp0[6] pp0[5] pp0[4] pp0[3] pp0[2] pp0[1] pp0[0] 
+ pp1[6] pp1[5] pp1[4] pp1[3] pp1[2] pp1[1] pp1[0] 
+ pp2[6] pp2[5] pp2[4] pp2[3] pp2[2] pp2[1] pp2[0] PartialProduct

*PartialProduct addition
Xpp_add pp0[6] pp0[5] pp0[4] pp0[3] pp0[2] pp0[1] pp0[0]
+ pp1[6] pp1[5] pp1[4] pp1[3] pp1[2] pp1[1] pp1[0]
+ pp2[6] pp2[5] pp2[4] pp2[3] pp2[2] pp2[1] pp2[0]
+ B_d[5] B_d[3] B_d[1]
+ AB[11] AB[10] AB[9] AB[8] AB[7] AB[6]
+ AB[5] AB[4] AB[3] AB[2] AB[1] AB[0] PartialProduct_Addition

*DFF to the second stage
Xdff27 CLK_IN CLK_v MODE_d[0] MODE_d2[0] DFF
Xdff28 CLK_IN CLK_v MODE_d[1] MODE_d2[1] DFF

Xdff29 CLK_IN CLK_v AB[11] AB_d2[11] DFF
Xdff30 CLK_IN CLK_v AB[10] AB_d2[10] DFF
Xdff31 CLK_IN CLK_v AB[9] AB_d2[9] DFF
Xdff32 CLK_IN CLK_v AB[8] AB_d2[8] DFF
Xdff33 CLK_IN CLK_v AB[7] AB_d2[7] DFF
Xdff34 CLK_IN CLK_v AB[6] AB_d2[6] DFF
Xdff35 CLK_IN CLK_v AB[5] AB_d2[5] DFF
Xdff36 CLK_IN CLK_v AB[4] AB_d2[4] DFF
Xdff37 CLK_IN CLK_v AB[3] AB_d2[3] DFF
Xdff38 CLK_IN CLK_v AB[2] AB_d2[2] DFF
Xdff39 CLK_IN CLK_v AB[1] AB_d2[1] DFF
Xdff40 CLK_IN CLK_v AB[0] AB_d2[0] DFF

Xdff41 CLK_IN CLK_v A_d[5] A_d2[5] DFF
Xdff42 CLK_IN CLK_v A_d[4] A_d2[4] DFF
Xdff43 CLK_IN CLK_v A_d[3] A_d2[3] DFF
Xdff44 CLK_IN CLK_v A_d[2] A_d2[2] DFF
Xdff45 CLK_IN CLK_v A_d[1] A_d2[1] DFF
Xdff46 CLK_IN CLK_v A_d[0] A_d2[0] DFF

Xdff47 CLK_IN CLK_v B_d[5] B_d2[5] DFF
Xdff48 CLK_IN CLK_v B_d[4] B_d2[4] DFF
Xdff49 CLK_IN CLK_v B_d[3] B_d2[3] DFF
Xdff50 CLK_IN CLK_v B_d[2] B_d2[2] DFF
Xdff51 CLK_IN CLK_v B_d[1] B_d2[1] DFF
Xdff52 CLK_IN CLK_v B_d[0] B_d2[0] DFF

Xdff53 CLK_IN CLK_v ACC_d[11]	ACC_d2[11] DFF
Xdff54 CLK_IN CLK_v ACC_d[10]	ACC_d2[10] DFF
Xdff55 CLK_IN CLK_v ACC_d[9]	ACC_d2[9] DFF
Xdff56 CLK_IN CLK_v ACC_d[8]	ACC_d2[8] DFF
Xdff57 CLK_IN CLK_v ACC_d[7]	ACC_d2[7] DFF
Xdff58 CLK_IN CLK_v ACC_d[6]	ACC_d2[6] DFF
Xdff59 CLK_IN CLK_v ACC_d[5]	ACC_d2[5] DFF
Xdff60 CLK_IN CLK_v ACC_d[4]	ACC_d2[4] DFF
Xdff61 CLK_IN CLK_v ACC_d[3]	ACC_d2[3] DFF
Xdff62 CLK_IN CLK_v ACC_d[2]	ACC_d2[2] DFF
Xdff63 CLK_IN CLK_v ACC_d[1]	ACC_d2[1] DFF
Xdff64 CLK_IN CLK_v ACC_d[0]	ACC_d2[0] DFF
*end of DFF

*second stage now

*invert MODE
*parallel connection
Xinv_m1 MODE_d2[1] MODE_v[1] INV
Xinv_m2 MODE_d2[1] MODE_v[1] INV
Xinv_m3 MODE_d2[1] MODE_v[1] INV
Xinv_m4 MODE_d2[0] MODE_v[0] INV
Xinv_m5 MODE_d2[0] MODE_v[0] INV
Xinv_m6 MODE_d2[0] MODE_v[0] INV

*select add1 as A*B or A
Xmux2_13b_1 AB_d2[11] AB_d2[11] AB_d2[10] AB_d2[9] AB_d2[8] AB_d2[7]
+ AB_d2[6] AB_d2[5] AB_d2[4] AB_d2[3] AB_d2[2] AB_d2[1] AB_d2[0]
+ A_d2[5] A_d2[5] A_d2[5] A_d2[5] A_d2[5] A_d2[5]
+ A_d2[5] A_d2[5] A_d2[4] A_d2[3] A_d2[2] A_d2[1] A_d2[0] MODE_d2[1] MODE_v[1]
+ add1[12] add1[11] add1[10] add1[9] add1[8] add1[7]
+ add1[6] add1[5] add1[4] add1[3] add1[2] add1[1] add1[0] MUX2_13b

*select add2 as ACC or B
Xmux2_13b_2 ACC_d2[11] ACC_d2[11] ACC_d2[10] ACC_d2[9] ACC_d2[8] ACC_d2[7]
+ ACC_d2[6] ACC_d2[5] ACC_d2[4] ACC_d2[3] ACC_d2[2] ACC_d2[1] ACC_d2[0]
+ B_d2[5] B_d2[5] B_d2[5] B_d2[5] B_d2[5] B_d2[5]
+ B_d2[5] B_d2[5] B_d2[4] B_d2[3] B_d2[2] B_d2[1] B_d2[0] MODE_d2[1] MODE_v[1]
+ add2[12] add2[11] add2[10] add2[9] add2[8] add2[7]
+ add2[6] add2[5] add2[4] add2[3] add2[2] add2[1] add2[0] MUX2_13b

*add2 inversion
Xinv04 add2[12]	add2_v[12] INV
Xinv05 add2[11] add2_v[11] INV
Xinv06 add2[10] add2_v[10] INV
Xinv07 add2[9]	add2_v[9] INV
Xinv08 add2[8]	add2_v[8] INV
Xinv09 add2[7]	add2_v[7] INV
Xinv10 add2[6]	add2_v[6] INV
Xinv11 add2[5]	add2_v[5] INV
Xinv12 add2[4]	add2_v[4] INV
Xinv13 add2[3]	add2_v[3] INV
Xinv14 add2[2]	add2_v[2] INV
Xinv15 add2[1]	add2_v[1] INV
Xinv16 add2[0]	add2_v[0] INV

*select sign
Xmux2_13b_3 add2[12] add2[11] add2[10] add2[9] add2[8] add2[7]
+ add2[6] add2[5] add2[4] add2[3] add2[2] add2[1] add2[0]
+ add2_v[12] add2_v[11] add2_v[10] add2_v[9] add2_v[8] add2_v[7]
+ add2_v[6] add2_v[5] add2_v[4] add2_v[3] add2_v[2] add2_v[1] add2_v[0] MODE_d2[0] MODE_v[0]
+ add2sel[12] add2sel[11] add2sel[10] add2sel[9] add2sel[8] add2sel[7]
+ add2sel[6] add2sel[5] add2sel[4] add2sel[3] add2sel[2] add2sel[1] add2sel[0] MUX2_13b
Xmux2_1b GND VDD MODE_d2[0] MODE_v[0] Cin_add MUX2_1b

*add add1 & add2sel together, get summation answer
XCLA_13b add1[12] add1[11] add1[10] add1[9] add1[8] add1[7]
+ add1[6] add1[5] add1[4] add1[3] add1[2] add1[1] add1[0]
+ add2sel[12] add2sel[11] add2sel[10] add2sel[9] add2sel[8] add2sel[7]
+ add2sel[6] add2sel[5] add2sel[4] add2sel[3] add2sel[2] add2sel[1] add2sel[0]
+ Cin_add OUT_n[12] OUT_n[11] OUT_n[10] OUT_n[9] OUT_n[8]
+ OUT_n[7] OUT_n[6] OUT_n[5] OUT_n[4] OUT_n[3] OUT_n[2] OUT_n[1] OUT_n[0] Cout CLA_13b

*output enter DFF for the final stage
Xdff65 CLK_IN CLK_v OUT_n[12]	OUT[12] DFF
Xdff66 CLK_IN CLK_v OUT_n[11]	OUT[11] DFF
Xdff67 CLK_IN CLK_v OUT_n[10]	OUT[10] DFF
Xdff68 CLK_IN CLK_v OUT_n[9]	OUT[9] DFF
Xdff69 CLK_IN CLK_v OUT_n[8]	OUT[8] DFF
Xdff70 CLK_IN CLK_v OUT_n[7]	OUT[7] DFF
Xdff71 CLK_IN CLK_v OUT_n[6]	OUT[6] DFF
Xdff72 CLK_IN CLK_v OUT_n[5]	OUT[5] DFF
Xdff73 CLK_IN CLK_v OUT_n[4]	OUT[4] DFF
Xdff74 CLK_IN CLK_v OUT_n[3]	OUT[3] DFF
Xdff75 CLK_IN CLK_v OUT_n[2]	OUT[2] DFF
Xdff76 CLK_IN CLK_v OUT_n[1]	OUT[1] DFF
Xdff77 CLK_IN CLK_v OUT_n[0]	OUT[0] DFF
.ends

.subckt MUX2_1b A B MODE MODE_v OUT
Xnand1 A MODE_v w1 NAND2
Xnand2 B MODE 	w2 NAND2
Xnand3 w1 w2 OUT NAND2
.ends

.subckt MUX2_13b
+ A[12] A[11] A[10] A[9] A[8] A[7]
+ A[6] A[5] A[4] A[3] A[2] A[1] A[0]
+ B[12] B[11] B[10] B[9] B[8] B[7]
+ B[6] B[5] B[4] B[3] B[2] B[1] B[0] MODE MODE_v
+ OUT[12] OUT[11] OUT[10] OUT[9] OUT[8] OUT[7]
+ OUT[6] OUT[5] OUT[4] OUT[3] OUT[2] OUT[1] OUT[0]
*select each bit by MUX2_1b
Xmux_1b_01 A[0] B[0] MODE MODE_v OUT[0] MUX2_1b
Xmux_1b_02 A[1] B[1] MODE MODE_v OUT[1] MUX2_1b
Xmux_1b_03 A[2] B[2] MODE MODE_v OUT[2] MUX2_1b
Xmux_1b_04 A[3] B[3] MODE MODE_v OUT[3] MUX2_1b
Xmux_1b_05 A[4] B[4] MODE MODE_v OUT[4] MUX2_1b
Xmux_1b_06 A[5] B[5] MODE MODE_v OUT[5] MUX2_1b
Xmux_1b_07 A[6] B[6] MODE MODE_v OUT[6] MUX2_1b
Xmux_1b_08 A[7] B[7] MODE MODE_v OUT[7] MUX2_1b
Xmux_1b_09 A[8] B[8] MODE MODE_v OUT[8] MUX2_1b
Xmux_1b_10 A[9] B[9] MODE MODE_v OUT[9] MUX2_1b
Xmux_1b_11 A[10] B[10] MODE MODE_v OUT[10] MUX2_1b
Xmux_1b_12 A[11] B[11] MODE MODE_v OUT[11] MUX2_1b
Xmux_1b_13 A[12] B[12] MODE MODE_v OUT[12] MUX2_1b
.ends

.subckt PartialProduct_Addition
+ P[6] P[5] P[4] P[3] P[2] P[1] P[0] 
+ Q[6] Q[5] Q[4] Q[3] Q[2] Q[1] Q[0] 
+ R[6] R[5] R[4] R[3] R[2] R[1] R[0] 
+ hot_one[2] hot_one[1] hot_one[0]
+ out[11] out[10] out[9] out[8] out[7] out[6]
+ out[5] out[4] out[3] out[2] out[1] out[0]

Xinv1 P[6] P6_v INV
Xinv2 Q[6] Q6_v INV
Xinv3 R[6] R6_v INV
*first stage
XAdder01 P[0] hot_one[0] sum1[0] cout1[0] HA
Xadder02 P[2] Q[0] hot_one[1] 	sum1[2]		cout1[2] FA
Xadder03 P[3] Q[1] sum1[3] 		cout1[3]	HA
Xadder04 P[4] Q[2] R[0] sum1[4]	cout1[4] FA
Xadder05 P[5] Q[3] R[1]	sum1[5] cout1[5] FA
Xadder06 P[6] Q[4] R[2]	sum1[6] cout1[6] FA
Xadder07 P[6] Q[5] R[3] sum1[7] cout1[7] FA
Xadder08 P[6] Q[6] R[4] sum1[8] cout1[8] FA
Xadder09 P6_v Q6_v R[5] sum1[9] cout1[9] FA
Xadder10 VDD R[6] sum1[10] cout1[10] HA
*second stage
Xadder11 P[1]	 cout1[0] 	sum2[1] cout2[1] HA
Xadder12 sum1[2] GND 		sum2[2] cout2[2] HA
Xadder13 sum1[3] cout1[2]	sum2[3] cout2[3] HA
Xadder14 sum1[4] cout1[3]	hot_one[2] sum2[4] cout2[4] FA
Xadder15 sum1[5] cout1[4] 	sum2[5] cout2[5] HA
Xadder16 sum1[6] cout1[5]	sum2[6] cout2[6] HA
Xadder17 sum1[7] cout1[6]	sum2[7] cout2[7] HA
Xadder18 sum1[8] cout1[7]	sum2[8] cout2[8] HA
Xadder19 sum1[9] cout1[8]	sum2[9] cout2[9] HA
Xadder20 sum1[10] cout1[9]	sum2[10] cout2[10] HA
Xadder21 R6_v	cout1[10] sum2[11] cout2[11] HA
*carry Lookahead Adder 12 bit: add Sum2 & Cout2
*finally we get multiple answer!(12b output) 
*Cin is GND too
XCLA_12b sum2[11] sum2[10] sum2[9] sum2[8] sum2[7] sum2[6]
+ sum2[5] sum2[4] sum2[3] sum2[2] sum2[1] sum1[0]
+ cout2[10] cout2[9] cout2[8] cout2[7] cout2[6] cout2[5]
+ cout2[4] cout2[3] cout2[2] cout2[1] GND GND GND 
+ out[11] out[10] out[9] out[8] out[7] out[6]
+ out[5] out[4] out[3] out[2] out[1] out[0] z CLA_12b
.ends

.subckt PartialProduct 
+ a[5] a[4] a[3] a[2] a[1] a[0] 
+ b[5] b[4] b[3] b[2] b[1] b[0]
+ pp0[6] pp0[5] pp0[4] pp0[3] pp0[2] pp0[1] pp0[0] 
+ pp1[6] pp1[5] pp1[4] pp1[3] pp1[2] pp1[1] pp1[0] 
+ pp2[6] pp2[5] pp2[4] pp2[3] pp2[2] pp2[1] pp2[0] 
*inverter
Xinv1 b[0] 	b0_v 	INV
Xinv2 b[1] 	b1_v 	INV
Xinv3 b[2] 	b2_v 	INV
Xinv4 b[3] 	b3_v 	INV
Xinv5 b[4] 	b4_v 	INV
Xinv6 b[5] 	b5_v 	INV
*pp0
Xbth1	GND	 b[0] b[1] VDD	b0_v b1_v XI[0] XI2[0]	BoothEncoder
Xbthsl01	a[0] GND	XI[0] XI2[0] b[1] pp0[0] BoothSelection
Xbthsl02	a[1] a[0] 	XI[0] XI2[0] b[1] pp0[1] BoothSelection
Xbthsl03	a[2] a[1] 	XI[0] XI2[0] b[1] pp0[2] BoothSelection
Xbthsl04	a[3] a[2] 	XI[0] XI2[0] b[1] pp0[3] BoothSelection
Xbthsl05	a[4] a[3] 	XI[0] XI2[0] b[1] pp0[4] BoothSelection
Xbthsl06	a[5] a[4] 	XI[0] XI2[0] b[1] pp0[5] BoothSelection
Xbthsl07	a[5] a[5] 	XI[0] XI2[0] b[1] pp0[6] BoothSelection
*pp1
Xbth2	b[1] b[2] b[3] b1_v	b2_v b3_v XI[1] XI2[1]	BoothEncoder
Xbthsl08	a[0] GND	XI[1] XI2[1] b[3] pp1[0] BoothSelection
Xbthsl09	a[1] a[0] 	XI[1] XI2[1] b[3] pp1[1] BoothSelection
Xbthsl10	a[2] a[1] 	XI[1] XI2[1] b[3] pp1[2] BoothSelection
Xbthsl11	a[3] a[2] 	XI[1] XI2[1] b[3] pp1[3] BoothSelection
Xbthsl12	a[4] a[3] 	XI[1] XI2[1] b[3] pp1[4] BoothSelection
Xbthsl13	a[5] a[4] 	XI[1] XI2[1] b[3] pp1[5] BoothSelection
Xbthsl14	a[5] a[5] 	XI[1] XI2[1] b[3] pp1[6] BoothSelection
*pp2
Xbth3	b[3] b[4] b[5] b3_v	b4_v b5_v XI[2] XI2[2]	BoothEncoder
Xbthsl15	a[0] GND	XI[2] XI2[2] b[5] pp2[0] BoothSelection
Xbthsl16	a[1] a[0] 	XI[2] XI2[2] b[5] pp2[1] BoothSelection
Xbthsl17	a[2] a[1] 	XI[2] XI2[2] b[5] pp2[2] BoothSelection
Xbthsl18	a[3] a[2] 	XI[2] XI2[2] b[5] pp2[3] BoothSelection
Xbthsl19	a[4] a[3] 	XI[2] XI2[2] b[5] pp2[4] BoothSelection
Xbthsl20	a[5] a[4] 	XI[2] XI2[2] b[5] pp2[5] BoothSelection
Xbthsl21	a[5] a[5] 	XI[2] XI2[2] b[5] pp2[6] BoothSelection	
.ends

.subckt CLA_13b 
+ A[12] A[11] A[10] A[9] A[8] A[7] A[6]
+ A[5] 	A[4]  A[3] A[2] A[1] A[0]
+ B[12] B[11] B[10] B[9] B[8] B[7] B[6] 
+ B[5] 	B[4]  B[3] B[2] B[1] B[0] Cin
+ Sum[12] Sum[11] Sum[10] Sum[9] Sum[8] Sum[7] Sum[6]
+ Sum[5]  Sum[4]  Sum[3] Sum[2] Sum[1] Sum[0] Cout

*13bit = 4*(3bit CLA) + 1*FA
XCLA_3b_1 A[2] A[1] A[0] B[2] B[1] B[0] 
+ Cin Sum[2] Sum[1] Sum[0] Carry[0] CLA_3b
XCLA_3b_2 A[5] A[4] A[3] B[5] B[4] B[3] 
+ Carry[0] Sum[5] Sum[4] Sum[3] Carry[1] CLA_3b
XCLA_3b_3 A[8] A[7] A[6] B[8] B[7] B[6]
+ Carry[1] Sum[8] Sum[7] Sum[6] Carry[2] CLA_3b
XCLA_3b_4 A[11] A[10] A[9] B[11] B[10] B[9] 
+ Carry[2] Sum[11] Sum[10] Sum[9] Carry[3] CLA_3b
XFA A[12] B[12] Carry[3] Sum[12] Cout FA
.ends

.subckt CLA_12b 
+ A[11] A[10] A[9] A[8] A[7] A[6]
+ A[5] 	A[4]  A[3] A[2] A[1] A[0]
+ B[11] B[10] B[9] B[8] B[7] B[6] 
+ B[5] 	B[4]  B[3] B[2] B[1] B[0] Cin
+ Sum[11] Sum[10] Sum[9] Sum[8] Sum[7] Sum[6]
+ Sum[5]  Sum[4]  Sum[3] Sum[2] Sum[1] Sum[0] Cout

*12bit = 4*(3bit CLA)
XCLA_3b_1 A[2] A[1] A[0] B[2] B[1] B[0] 
+ Cin Sum[2] Sum[1] Sum[0] Carry[0] CLA_3b
XCLA_3b_2 A[5] A[4] A[3] B[5] B[4] B[3] 
+ Carry[0] Sum[5] Sum[4] Sum[3] Carry[1] CLA_3b
XCLA_3b_3 A[8] A[7] A[6] B[8] B[7] B[6]
+ Carry[1] Sum[8] Sum[7] Sum[6] Carry[2] CLA_3b
XCLA_3b_4 A[11] A[10] A[9] B[11] B[10] B[9] 
+ Carry[2] Sum[11] Sum[10] Sum[9] Cout CLA_3b
.ends

.subckt CLA_3b A[2] A[1] A[0] B[2] B[1] B[0]
+ Cin Sum[2] Sum[1] Sum[0] Cout
Xinv1 A[2] A_v[2] INV
Xinv2 A[1] A_v[1] INV
Xinv3 A[0] A_v[0] INV
Xinv4 B[2] B_v[2] INV
Xinv5 B[1] B_v[1] INV
Xinv6 B[0] B_v[0] INV
*P = A xor B
Xxor1 A[0] B[0] A_v[0] B_v[0] P[0] XOR2
Xxor2 A[1] B[1] A_v[1] B_v[1] P[1] XOR2
Xxor3 A[2] B[2] A_v[2] B_v[2] P[2] XOR2
*G = A & B
Xnand01	A[0] B[0] Ginv[0] NAND2
Xnand02	A[1] B[1] Ginv[1] NAND2
Xnand03 A[2] B[2] Ginv[2] NAND2
Xinv7 Ginv[0] G[0] INV
Xinv8 Ginv[1] G[1] INV
Xinv9 Ginv[2] G[2] INV
*C1 = G0 + P0Cin
Xnand05 P[0] Cin w0 NAND2
Xnand06 Ginv[0] w0 Carry[0] NAND2
*C2 = G1 + P1G0 + P1P0Cin
Xnand07 P[1] G[0] w1 NAND2
Xnand08 P[1] P[0] Cin w2 NAND3
Xnand09 Ginv[1] w2 w1 Carry[1] NAND3 
*C3 = G2 + P2G1 + P2P1G0 + P2P1P0Cin
Xnand10 P[2] G[1] w3 NAND2
Xnand11 P[2] P[1] G[0] w4 NAND3
Xnand12 P[2] P[1] P[0] Cin  w5 NAND4
Xnand13 Ginv[2] w3 w4 w5 Cout NAND4
*calculate sum
Xinv10 P[0] P_v[0] INV
Xinv11 P[1] P_v[1] INV
Xinv12 P[2] P_v[2] INV
Xinv13 Cin	Cin_v INV
Xinv14 Carry[0] Carry_v[0] INV
Xinv15 Carry[1] Carry_v[1] INV
Xxor4 P[0] Cin 		P_v[0] Cin_v 		Sum[0] XOR2
Xxor5 P[1] Carry[0] P_v[1] Carry_v[0]	Sum[1] XOR2
Xxor6 P[2] Carry[1] P_v[2] Carry_v[1]	Sum[2] XOR2	
.ends

.subckt BoothSelection	yj	yj_1 XI XI2	MI OUT
Xnand1	yj 		XI	n1 	NAND2
Xnand2	yj_1	XI2	n2	NAND2
Xnand3	n1	n2	n3	NAND2
Xinv1	n3	n3_v	INV
Xinv2	MI	MI_v	INV
Xxor1	n3	MI	n3_v	MI_v OUT	XOR2
.ends
 
.subckt HA INA INB Sum Cout
Xinv1 INA INA_v INV
Xinv2 INB INB_v INV
Xxor INA INB INA_v INB_v Sum XOR2
Xand INA INB Cout_v NAND2
Xinv Cout_v Cout INV
.ends
*
*.subckt FA	A B CIN SUM COUT
*mp1		n1	A	VDD VDD P_18_G2 w=wp l=0.18u
*mp2 	n1	B 	VDD VDD P_18_G2 w=wp l=0.18u
*mp3 	n2	CIN n1	VDD P_18_G2 w=wp l=0.18u
*mp4 	n4 	A	VDD	VDD P_18_G2 w=wp l=0.18u
*mp5 	n6	A	VDD VDD P_18_G2 w=wp l=0.18u
*mp6 	n6	B 	VDD VDD P_18_G2 w=wp l=0.18u
*mp7 	n6	CIN VDD VDD P_18_G2 w=wp l=0.18u
*mp8 	n7	n2	n6	VDD P_18_G2 w=wp l=0.18u
*mp9		n9 	B	VDD	VDD P_18_G2 w=wp l=0.18u
*mp10	n10 A	n9	VDD P_18_G2 w=wp l=0.18u
*mp11	n7	CIN	n10	VDD P_18_G2 w=wp l=0.18u
*mp12 	n2	B	n4	VDD	P_18_G2 w=wp l=0.18u

*mn1		n2	CIN	n3	GND N_18_G2 w=wn l=0.18u
*mn2		n3	A	GND	GND N_18_G2 w=wn l=0.18u
*mn3		n3	B	GND GND N_18_G2 w=wn l=0.18u
*mn4		n2	B	n5	GND	N_18_G2 w=wn l=0.18u
*mn5		n5	A	GND GND	N_18_G2 w=wn l=0.18u
*mn6		n7	n2	n8	GND	N_18_G2 w=wn l=0.18u
*mn7		n8	A 	GND	GND	N_18_G2 w=wn l=0.18u
*mn8		n8	B	GND	GND	N_18_G2 w=wn l=0.18u
*mn9		n8	CIN	GND	GND	N_18_G2 w=wn l=0.18u
*mn10	n7	CIN	n11	GND	N_18_G2 w=wn l=0.18u
*mn11	n11	A	n12	GND	N_18_G2 w=wn l=0.18u
*mn12	n12	B	GND	GND	N_18_G2 w=wn l=0.18u

*X1	n7	SUM		INV
*X2	n2	COUT	INV
*.ends


.subckt FA A B CIN SUM COUT
X1 A B 1 XOR 
X2 A B 2 NAND2 
X3 1 CIN SUM XOR 
X4 CIN 1 3 NAND2 
X5 3 2 COUT NAND2 
*X6 CC1 CC2 INV
*X7 CC2 COUT INV
*X8 SS1 SS2 INV
*X9 SS2 SUM INV 
.ends FA


.subckt XOR A B OUT 
mp3 OUT B A VDD P_18_G2 w=wp l=0.18u
mp4 OUT A B VDD P_18_G2 w=wp l=0.18u
mp5 1 A VDD VDD P_18_G2 w=wp l=0.18u
mn3 OUT B 1 GND N_18_G2 w=wn l=0.18u
mn4 OUT 1 B GND N_18_G2 w=wn l=0.18u
mn5 1 A GND GND N_18_G2 w=wn l=0.18u
.ends XOR

.subckt BoothEncoder x2i_m x2i x2i_p x2i_m_v x2i_v x2i_p_v XI XI2
Xxor1	x2i_m	x2i	x2i_m_v	x2i_v	XI		XOR2
Xnand1	x2i_m	x2i		x2i_p_v	n1	NAND3
Xnand2	x2i_m_v	x2i_v	x2i_p	n2	NAND3
Xnand3	n1	n2	XI2	NAND2
.ends
	 
.subckt DFF CLK CLK_V D Q
Xinv1	D	Din	INV

mn1	n1	CLK_V	Din	GND	N_18_G2	w=wn 	l=0.18u
mp1 Din	CLK 	n1	VDD	P_18_G2	w=wp 	l=0.18u
X1	n1	QM	INV
mn2	n3	CLK		QM	GND	N_18_G2	w=wn 	l=0.18u
mp2	QM	CLK_V	n3	VDD P_18_G2	w=wp 	l=0.18u
X2	n3	Qo	INV
X3	QM	n4	INV
mn3	n1	CLK		n4	GND	N_18_G2 w=wn	l=0.18u
mp3	n4	CLK_V	n1	VDD	P_18_G2 w=wp	l=0.18u
X4	Qo 	n5	INV
mn4	n3	CLK_V	n5	GND	N_18_G2 w=wn	l=0.18u
mp4	n5	CLK		n3	VDD	P_18_G2	w=wp	l=0.18u

Xinv2	Qo Q INV
.ends

.subckt NAND4 INA INB INC IND OUT
mp1 OUT INA VDD VDD P_18_G2 w=wp l=0.18u
mp2 OUT INB VDD VDD P_18_G2 w=wp l=0.18u
mp3 OUT INC VDD VDD P_18_G2 w=wp l=0.18u
mp4 OUT IND VDD VDD P_18_G2 w=wp l=0.18u

mn1 OUT IND n1	GND N_18_G2 w=wn l=0.18u
mn2 n1 	INC	n2	GND N_18_G2 w=wn l=0.18u
mn3	n2	INB	n3  GND N_18_G2 w=wn l=0.18u
mn4 n3 	INA	GND GND N_18_G2 w=wn l=0.18u
.ends

.subckt NAND3 INA INB INC OUT
mp1 OUT INA VDD VDD P_18_G2 w=wp l=0.18u
mp2 OUT INB VDD VDD P_18_G2 w=wp l=0.18u
mp3 OUT INC VDD VDD P_18_G2 w=wp l=0.18u
                    
mn1 OUT INC n1	GND N_18_G2 w=wn l=0.18u
mn2 n1 	INB	n2	GND N_18_G2 w=wn l=0.18u
mn3	n2	INA	GND GND N_18_G2 w=wn l=0.18u
.ends

.subckt NAND2 INA INB OUT
mp1 OUT INA VDD VDD P_18_G2 w=wp l=0.18u
mp2 OUT INB VDD VDD P_18_G2 w=wp l=0.18u
                     
mn1 OUT INA n1	GND N_18_G2 w=wn l=0.18u
mn2 n1 	INB	GND	GND N_18_G2 w=wn l=0.18u
.ends

.subckt XOR2 INA INB INA_V INB_V OUT
mp1	n1	INA_V	VDD VDD P_18_G2 w=wp l=0.18u
mp2 OUT	INB		n1	VDD P_18_G2 w=wp l=0.18u
mp3 n2	INA		VDD VDD P_18_G2 w=wp l=0.18u
mp4 OUT INB_V	n2	VDD P_18_G2 w=wp l=0.18u
                   
mn1 OUT INB		n3	GND N_18_G2 w=wn l=0.18u
mn2 n3	INA		GND GND N_18_G2 w=wn l=0.18u
mn3 OUT INB_V	n4	GND N_18_G2 w=wn l=0.18u
mn4 n4	INA_V	GND GND N_18_G2 w=wn l=0.18u
.ends

*.subckt Tri_INV IN EN EN_V OUT
*mp1 n1	IN		VDD VDD P_18_G2 w=wp l=0.18u
*mp2 OUT EN_V 	n1	VDD P_18_G2 w=wp l=0.18u
*mn1 OUT EN		n2	GND N_18_G2 w=wn l=0.18u
*mn2 n2	IN		GND GND N_18_G2 w=wn l=0.18u
*.ends

.subckt INV IN OUT
mp OUT	IN	VDD	VDD	P_18_G2	w=wp l=0.18u
mn OUT 	IN	GND	GND	N_18_G2	w=wn l=0.18u
.ends

.end
