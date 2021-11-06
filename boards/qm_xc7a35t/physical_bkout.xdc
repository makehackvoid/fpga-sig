## A general .xdc for the QMTech A7-35T Rev. 4

## Design Properties
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]

## Clock signal
set_property -dict { PACKAGE_PIN N11    IOSTANDARD LVCMOS33 } [get_ports { CLK50MHZ }]; #IO_L13P_T2_MRCC_14
create_clock -add -name sys_clk_pin -period 20.00 -waveform {0 10} [get_ports { CLK50MHZ }];

## LEDs (0 = D3 on core, [1:5] = D1:5 on breakout)
## Active low
set_property -dict { PACKAGE_PIN E6     IOSTANDARD LVCMOS33 } [get_ports { LED[0] }]; #IO_0_35
set_property -dict { PACKAGE_PIN R6     IOSTANDARD LVCMOS33 } [get_ports { LED[1] }]; #IO_L24P_T3_A01_D17_14 U7-40
set_property -dict { PACKAGE_PIN T5     IOSTANDARD LVCMOS33 } [get_ports { LED[2] }]; #IO_L23N_T3_A02_D18_14 U7-39
set_property -dict { PACKAGE_PIN R7     IOSTANDARD LVCMOS33 } [get_ports { LED[3] }]; #IO_L24N_T3_A00_D16_14 U7-38
set_property -dict { PACKAGE_PIN T7     IOSTANDARD LVCMOS33 } [get_ports { LED[4] }]; #IO_L21P_T3_DQS_14 U7-37
set_property -dict { PACKAGE_PIN R8     IOSTANDARD LVCMOS33 } [get_ports { LED[5] }]; #IO_L20N_T3_A07_D23_14 U7-36

## PB Buttons (0 = SW2 on core, [1:5] = SW1:5 on breakout)
## Active low
set_property -dict { PACKAGE_PIN K5     IOSTANDARD LVCMOS33 } [get_ports { PB[0] }]; #IO_25_35
set_property -dict { PACKAGE_PIN B7     IOSTANDARD LVCMOS33 } [get_ports { PB[1] }]; #IO_L1P_T0_AD4P_35 U8-7
set_property -dict { PACKAGE_PIN M6     IOSTANDARD LVCMOS33 } [get_ports { PB[2] }]; #IO_L19P_T3_A10_D26_14 U7-44
set_property -dict { PACKAGE_PIN N6     IOSTANDARD LVCMOS33 } [get_ports { PB[3] }]; #IO_L19N_T3_A09_D25_VREF_14 U7-43
set_property -dict { PACKAGE_PIN R5     IOSTANDARD LVCMOS33 } [get_ports { PB[4] }]; #IO_L23P_T3_A03_D19_14 U7-42
set_property -dict { PACKAGE_PIN P6     IOSTANDARD LVCMOS33 } [get_ports { PB[5] }]; #IO_25_14 U7-41

## USB/RS-232 CP2102N
#set_property -dict { PACKAGE_PIN T14    IOSTANDARD LVCMOS33 } [get_ports { rxd }]; #IO_L10P_T1_D14_14 U7-15
#set_property -dict { PACKAGE_PIN T15    IOSTANDARD LVCMOS33 } [get_ports { txd }]; #IO_L10N_T1_D15_14 U7-16

## 7 segment display
## Anodes, active high (unusually the circuit is using NPN, not PNP, transistors)
set_property -dict { PACKAGE_PIN T8     IOSTANDARD LVCMOS33 } [get_ports { AN[2] }]; #IO_L21N_T3_DQS_A06_D22_14 U7-35
set_property -dict { PACKAGE_PIN P10    IOSTANDARD LVCMOS33 } [get_ports { AN[1] }]; #IO_L14P_T2_SRCC_14 U7-27
set_property -dict { PACKAGE_PIN T9     IOSTANDARD LVCMOS33 } [get_ports { AN[0] }]; #IO_L22P_T3_A05_D21_14 U7-33
## A-G,DP = seg[0:7], active low
set_property -dict { PACKAGE_PIN T10    IOSTANDARD LVCMOS33 } [get_ports { SEG[0] }]; #IO_L22N_T3_A04_D20_14 U7-31
set_property -dict { PACKAGE_PIN K13    IOSTANDARD LVCMOS33 } [get_ports { SEG[1] }]; #IO_L5P_T0_D06_14 U7-26
set_property -dict { PACKAGE_PIN P11    IOSTANDARD LVCMOS33 } [get_ports { SEG[2] }]; #IO_L14N_T2_SRCC_14 U7-28
set_property -dict { PACKAGE_PIN R11    IOSTANDARD LVCMOS33 } [get_ports { SEG[3] }]; #IO_L17N_T2_A13_D29_14 U7-32
set_property -dict { PACKAGE_PIN R10    IOSTANDARD LVCMOS33 } [get_ports { SEG[4] }]; #IO_L17P_T2_A14_D30_14 U7-34
set_property -dict { PACKAGE_PIN N9     IOSTANDARD LVCMOS33 } [get_ports { SEG[5] }]; #IO_L18P_T2_A12_D28_14 U7-29
set_property -dict { PACKAGE_PIN K12    IOSTANDARD LVCMOS33 } [get_ports { SEG[6] }]; #IO_0_14 U7-25
set_property -dict { PACKAGE_PIN P9     IOSTANDARD LVCMOS33 } [get_ports { SEG[7] }]; #IO_L18N_T2_A11_D27_14 U7-30

## VGA
#set_property -dict { PACKAGE_PIN G1     IOSTANDARD LVCMOS33 } [get_ports { VGA_HS }]; #IO_L17N_T2_35 U8-44
#set_property -dict { PACKAGE_PIN G2     IOSTANDARD LVCMOS33 } [get_ports { VGA_VS }]; #IO_L17P_T2_35 U8-43
#set_property -dict { PACKAGE_PIN N2     IOSTANDARD LVCMOS33 } [get_ports { VGA_R[0] }]; #IO_L3N_T0_DQS_34 U8-60
#set_property -dict { PACKAGE_PIN M4     IOSTANDARD LVCMOS33 } [get_ports { VGA_R[1] }]; #IO_L1N_T0_34 U8-58
#set_property -dict { PACKAGE_PIN N3     IOSTANDARD LVCMOS33 } [get_ports { VGA_R[2] }]; #IO_L3P_T0_DQS_34 U8-59
#set_property -dict { PACKAGE_PIN K2     IOSTANDARD LVCMOS33 } [get_ports { VGA_R[3] }]; #IO_L24N_T3_35 U8-56
#set_property -dict { PACKAGE_PIN L4     IOSTANDARD LVCMOS33 } [get_ports { VGA_R[4] }]; #IO_L1P_T0_34 U8-57
#set_property -dict { PACKAGE_PIN K3     IOSTANDARD LVCMOS33 } [get_ports { VGA_G[0] }]; #IO_L24P_T3_35 U8-55
#set_property -dict { PACKAGE_PIN H3     IOSTANDARD LVCMOS33 } [get_ports { VGA_G[1] }]; #IO_L21N_T3_DQS_35 U8-54
#set_property -dict { PACKAGE_PIN H4     IOSTANDARD LVCMOS33 } [get_ports { VGA_G[2] }]; #IO_L18N_T2_35 U8-52
#set_property -dict { PACKAGE_PIN J3     IOSTANDARD LVCMOS33 } [get_ports { VGA_G[3] }]; #IO_L21P_T3_DQS_35 U8-53
#set_property -dict { PACKAGE_PIN L2     IOSTANDARD LVCMOS33 } [get_ports { VGA_G[4] }]; #IO_L23N_T3_35 U8-50
#set_property -dict { PACKAGE_PIN H5     IOSTANDARD LVCMOS33 } [get_ports { VGA_G[5] }]; #IO_L18P_T2_35 U8-51
#set_property -dict { PACKAGE_PIN L3     IOSTANDARD LVCMOS33 } [get_ports { VGA_B[0] }]; #IO_L23P_T3_35 U8-49
#set_property -dict { PACKAGE_PIN K1     IOSTANDARD LVCMOS33 } [get_ports { VGA_B[1] }]; #IO_L22P_T3_35 U8-47
#set_property -dict { PACKAGE_PIN J1     IOSTANDARD LVCMOS33 } [get_ports { VGA_B[2] }]; #IO_L22N_T3_35 U8-48
#set_property -dict { PACKAGE_PIN H2     IOSTANDARD LVCMOS33 } [get_ports { VGA_B[3] }]; #IO_L20P_T3_35 U8-45
#set_property -dict { PACKAGE_PIN H1     IOSTANDARD LVCMOS33 } [get_ports { VGA_B[4] }]; #IO_L20N_T3_35 U8-46

## Micro SD
#set_property -dict { PACKAGE_PIN A7     IOSTANDARD LVCMOS33 } [get_ports { sd_cd }]; #IO_L1N_T0_AD4N_35 U8-8
#set_property -dict { PACKAGE_PIN B6     IOSTANDARD LVCMOS33 } [get_ports { sd_dat[1] }]; #IO_L2P_T0_AD12P_35 U8-9
#set_property -dict { PACKAGE_PIN B5     IOSTANDARD LVCMOS33 } [get_ports { sd_dat[0] }]; #IO_L2N_T0_AD12N_35 U8-10
#set_property -dict { PACKAGE_PIN E6     IOSTANDARD LVCMOS33 } [get_ports { sd_clk }]; #IO_0_35 U8-11
#set_property -dict { PACKAGE_PIN K5     IOSTANDARD LVCMOS33 } [get_ports { sd_cmd }]; #IO_25_35 U8-12
#set_property -dict { PACKAGE_PIN J5     IOSTANDARD LVCMOS33 } [get_ports { sd_dat[3] }]; #IO_L19P_T3_35 U8-13
#set_property -dict { PACKAGE_PIN J4     IOSTANDARD LVCMOS33 } [get_ports { sd_dat[2] }]; #IO_L19N_T3_VREF_35 U8-14

## PMod J10 ([0:3] = pins 1-4, [4:7] = pins 7-10)
#set_property -dict { PACKAGE_PIN P13    IOSTANDARD LVCMOS33 } [get_ports { j10[0] }]; #IO_L11N_T1_SRCC_14 U7-17
#set_property -dict { PACKAGE_PIN T13    IOSTANDARD LVCMOS33 } [get_ports { j10[1] }]; #IO_L16N_T2_A15_D31_14 U7-19
#set_property -dict { PACKAGE_PIN T12    IOSTANDARD LVCMOS33 } [get_ports { j10[2] }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 U7-21
#set_property -dict { PACKAGE_PIN L13    IOSTANDARD LVCMOS33 } [get_ports { j10[3] }]; #IO_L5N_T0_D07_14 U7-23
#set_property -dict { PACKAGE_PIN P14    IOSTANDARD LVCMOS33 } [get_ports { j10[4] }]; #IO_L12N_T1_MRCC_14 U7-18
#set_property -dict { PACKAGE_PIN R13    IOSTANDARD LVCMOS33 } [get_ports { j10[5] }]; #IO_L16P_T2_CSI_B_14 U7-20
#set_property -dict { PACKAGE_PIN R12    IOSTANDARD LVCMOS33 } [get_ports { j10[6] }]; #IO_L15P_T2_DQS_RDWR_B_14 U7-22
#set_property -dict { PACKAGE_PIN N12    IOSTANDARD LVCMOS33 } [get_ports { j10[7] }]; #IO_L13N_T2_MRCC_14 U7-24

## PMod J11 ([0:3] = pins 1-4, [4:7] = pins 7-10)
#set_property -dict { PACKAGE_PIN M12    IOSTANDARD LVCMOS33 } [get_ports { j11[0] }]; #IO_L6N_T0_D08_VREF_14 U7-7
#set_property -dict { PACKAGE_PIN N14    IOSTANDARD LVCMOS33 } [get_ports { j11[1] }]; #IO_L12P_T1_MRCC_14 U7-9
#set_property -dict { PACKAGE_PIN P15    IOSTANDARD LVCMOS33 } [get_ports { j11[2] }]; #IO_L8P_T1_D11_14 U7-11
#set_property -dict { PACKAGE_PIN R15    IOSTANDARD LVCMOS33 } [get_ports { j11[3] }]; #IO_L9P_T1_DQS_14 U7-13
#set_property -dict { PACKAGE_PIN N13    IOSTANDARD LVCMOS33 } [get_ports { j11[4] }]; #IO_L11P_T1_SRCC_14 U7-8
#set_property -dict { PACKAGE_PIN N16    IOSTANDARD LVCMOS33 } [get_ports { j11[5] }]; #IO_L7N_T1_D10_14 U7-10
#set_property -dict { PACKAGE_PIN P16    IOSTANDARD LVCMOS33 } [get_ports { j11[6] }]; #IO_L8N_T1_D12_14 U7-12
#set_property -dict { PACKAGE_PIN R16    IOSTANDARD LVCMOS33 } [get_ports { j11[7] }]; #IO_L9N_T1_DQS_D13_14 U7-14

## J1
#set_property -dict { PACKAGE_PIN L5     IOSTANDARD LVCMOS33 } [get_ports { j1[18] }]; #IO_0_34 U7-45
#set_property -dict { PACKAGE_PIN P5     IOSTANDARD LVCMOS33 } [get_ports { j1[17] }]; #IO_L10P_T1_34 U7-46
#set_property -dict { PACKAGE_PIN T4     IOSTANDARD LVCMOS33 } [get_ports { j1[16] }]; #IO_L9P_T1_DQS_34 U7-47
#set_property -dict { PACKAGE_PIN T3     IOSTANDARD LVCMOS33 } [get_ports { j1[15] }]; #IO_L9N_T1_DQS_34 U7-48
#set_property -dict { PACKAGE_PIN R3     IOSTANDARD LVCMOS33 } [get_ports { j1[14] }]; #IO_L8P_T1_34 U7-49
#set_property -dict { PACKAGE_PIN T2     IOSTANDARD LVCMOS33 } [get_ports { j1[13] }]; #IO_L8N_T1_34 U7-50
#set_property -dict { PACKAGE_PIN R2     IOSTANDARD LVCMOS33 } [get_ports { j1[12] }]; #IO_L7P_T1_34 U7-51
#set_property -dict { PACKAGE_PIN R1     IOSTANDARD LVCMOS33 } [get_ports { j1[11] }]; #IO_L7N_T1_34 U7-52
#set_property -dict { PACKAGE_PIN M5     IOSTANDARD LVCMOS33 } [get_ports { j1[10] }]; #IO_L6P_T0_34 U7-53
#set_property -dict { PACKAGE_PIN N4     IOSTANDARD LVCMOS33 } [get_ports { j1[9] }]; #IO_L6N_T0_VREF_34 U7-54
#set_property -dict { PACKAGE_PIN P4     IOSTANDARD LVCMOS33 } [get_ports { j1[8] }]; #IO_L5P_T0_34 U7-55
#set_property -dict { PACKAGE_PIN P3     IOSTANDARD LVCMOS33 } [get_ports { j1[7] }]; #IO_L5N_T0_34 U7-56
#set_property -dict { PACKAGE_PIN N1     IOSTANDARD LVCMOS33 } [get_ports { j1[6] }]; #IO_L4P_T0_34 U7-57
#set_property -dict { PACKAGE_PIN P1     IOSTANDARD LVCMOS33 } [get_ports { j1[5] }]; #IO_L4N_T0_34 U7-58
#set_property -dict { PACKAGE_PIN M2     IOSTANDARD LVCMOS33 } [get_ports { j1[4] }]; #IO_L2P_T0_34 U7-59
#set_property -dict { PACKAGE_PIN M1     IOSTANDARD LVCMOS33 } [get_ports { j1[3] }]; #IO_L2N_T0_34 U7-60

## DDR3 - Micron MT41K128M16JT (2Gbit, 128M x 16)
#set_property -dict { PACKAGE_PIN B14    IOSTANDARD LVCMOS15 } [get_ports { ddr_a[0] }]; #IO_L8N_T1_AD10N_15
#set_property -dict { PACKAGE_PIN C8     IOSTANDARD LVCMOS15 } [get_ports { ddr_a[1] }]; #IO_L1P_T0_AD0P_15
#set_property -dict { PACKAGE_PIN A14    IOSTANDARD LVCMOS15 } [get_ports { ddr_a[2] }]; #IO_L7N_T1_AD2N_15
#set_property -dict { PACKAGE_PIN C14    IOSTANDARD LVCMOS15 } [get_ports { ddr_a[3] }]; #IO_L8P_T1_AD10P_15
#set_property -dict { PACKAGE_PIN C9     IOSTANDARD LVCMOS15 } [get_ports { ddr_a[4] }]; #IO_L1N_T0_AD0N_15
#set_property -dict { PACKAGE_PIN B10    IOSTANDARD LVCMOS15 } [get_ports { ddr_a[5] }]; #IO_L4P_T0_15
#set_property -dict { PACKAGE_PIN D9     IOSTANDARD LVCMOS15 } [get_ports { ddr_a[6] }]; #IO_L6N_T0_VREF_15
#set_property -dict { PACKAGE_PIN A12    IOSTANDARD LVCMOS15 } [get_ports { ddr_a[7] }]; #IO_L5N_T0_AD9N_15
#set_property -dict { PACKAGE_PIN D8     IOSTANDARD LVCMOS15 } [get_ports { ddr_a[8] }]; #IO_L6P_T0_15
#set_property -dict { PACKAGE_PIN A13    IOSTANDARD LVCMOS15 } [get_ports { ddr_a[9] }]; #IO_L7P_T1_AD2P_15
#set_property -dict { PACKAGE_PIN B12    IOSTANDARD LVCMOS15 } [get_ports { ddr_a[10] }]; #IO_L5P_T0_AD9P_15
#set_property -dict { PACKAGE_PIN A9     IOSTANDARD LVCMOS15 } [get_ports { ddr_a[11] }]; #IO_L2N_T0_AD8N_15
#set_property -dict { PACKAGE_PIN A8     IOSTANDARD LVCMOS15 } [get_ports { ddr_a[12] }]; #IO_L2P_T0_AD8P_15
#set_property -dict { PACKAGE_PIN B11    IOSTANDARD LVCMOS15 } [get_ports { ddr_a[13] }]; #IO_L4N_T0_15

#set_property -dict { PACKAGE_PIN F15    IOSTANDARD LVCMOS15 } [get_ports { ddr_d[0] }]; #IO_L18P_T2_A24_15
#set_property -dict { PACKAGE_PIN F13    IOSTANDARD LVCMOS15 } [get_ports { ddr_d[1] }]; #IO_L16N_T2_A27_15
#set_property -dict { PACKAGE_PIN E16    IOSTANDARD LVCMOS15 } [get_ports { ddr_d[2] }]; #IO_L17P_T2_A26_15
#set_property -dict { PACKAGE_PIN D11    IOSTANDARD LVCMOS15 } [get_ports { ddr_d[3] }]; #IO_L14N_T2_SRCC_15
#set_property -dict { PACKAGE_PIN E12    IOSTANDARD LVCMOS15 } [get_ports { ddr_d[4] }]; #IO_L13P_T2_MRCC_15
#set_property -dict { PACKAGE_PIN E13    IOSTANDARD LVCMOS15 } [get_ports { ddr_d[5] }]; #IO_L13N_T2_MRCC_15
#set_property -dict { PACKAGE_PIN D16    IOSTANDARD LVCMOS15 } [get_ports { ddr_d[6] }]; #IO_L17N_T2_A25_15
#set_property -dict { PACKAGE_PIN E11    IOSTANDARD LVCMOS15 } [get_ports { ddr_d[7] }]; #IO_L14P_T2_SRCC_15
#set_property -dict { PACKAGE_PIN G12    IOSTANDARD LVCMOS15 } [get_ports { ddr_d[8] }]; #IO_L19N_T3_A21_VREF_15
#set_property -dict { PACKAGE_PIN J16    IOSTANDARD LVCMOS15 } [get_ports { ddr_d[9] }]; #IO_L23N_T3_FWE_B_15
#set_property -dict { PACKAGE_PIN G16    IOSTANDARD LVCMOS15 } [get_ports { ddr_d[10] }]; #IO_L22N_T3_A16_15
#set_property -dict { PACKAGE_PIN J15    IOSTANDARD LVCMOS15 } [get_ports { ddr_d[11] }]; #IO_L23P_T3_FOE_B_15
#set_property -dict { PACKAGE_PIN H14    IOSTANDARD LVCMOS15 } [get_ports { ddr_d[12] }]; #IO_L24P_T3_RS1_15
#set_property -dict { PACKAGE_PIN H12    IOSTANDARD LVCMOS15 } [get_ports { ddr_d[13] }]; #IO_L20P_T3_A20_15
#set_property -dict { PACKAGE_PIN H16    IOSTANDARD LVCMOS15 } [get_ports { ddr_d[14] }]; #IO_L22P_T3_A17_15
#set_property -dict { PACKAGE_PIN H13    IOSTANDARD LVCMOS15 } [get_ports { ddr_d[15] }]; #IO_L20N_T3_A19_15

#set_property -dict { PACKAGE_PIN E15    IOSTANDARD LVCMOS15 } [get_ports { ddr_resetn }]; #IO_L18N_T2_A23_15
#set_property -dict { PACKAGE_PIN F12    IOSTANDARD LVCMOS15 } [get_ports { ddr_dqm[0] }]; #IO_L16P_T2_A28_15
#set_property -dict { PACKAGE_PIN H11    IOSTANDARD LVCMOS15 } [get_ports { ddr_dqm[1] }]; #IO_L19P_T3_A22_15
#set_property -dict { PACKAGE_PIN D14    IOSTANDARD LVDS } [get_ports { ddr_dqs[0] }]; #IO_L15P_T2_DQS_15
#set_property -dict { PACKAGE_PIN G14    IOSTANDARD LVDS } [get_ports { ddr_dqs[1] }]; #IO_L21P_T3_DQS_15
#set_property -dict { PACKAGE_PIN B9     IOSTANDARD LVDS } [get_ports { ddr_clk }]; #IO_L3P_T0_DQS_AD1P_15
#set_property -dict { PACKAGE_PIN B15    IOSTANDARD LVCMOS15 } [get_ports { ddr_ba[2] }]; #IO_L9P_T1_DQS_AD3P_15
#set_property -dict { PACKAGE_PIN A15    IOSTANDARD LVCMOS15 } [get_ports { ddr_ba[1] }]; #IO_L9N_T1_DQS_AD3N_15
#set_property -dict { PACKAGE_PIN C16    IOSTANDARD LVCMOS15 } [get_ports { ddr_ba[0] }]; #IO_L10P_T1_AD11P_15
#set_property -dict { PACKAGE_PIN B16    IOSTANDARD LVCMOS15 } [get_ports { ddr_ras }]; #IO_L10N_T1_AD11N_15
#set_property -dict { PACKAGE_PIN C11    IOSTANDARD LVCMOS15 } [get_ports { ddr_cas }]; #IO_L11P_T1_SRCC_15
#set_property -dict { PACKAGE_PIN C12    IOSTANDARD LVCMOS15 } [get_ports { ddr_we }]; #IO_L11N_T1_SRCC_15
#set_property -dict { PACKAGE_PIN D13    IOSTANDARD LVCMOS15 } [get_ports { ddr_cke }]; #IO_L12P_T1_MRCC_15
#set_property -dict { PACKAGE_PIN C13    IOSTANDARD LVCMOS15 } [get_ports { ddr_odt }]; #IO_L12N_T1_MRCC_15

## Ethernet
#set_property -dict { PACKAGE_PIN G5     IOSTANDARD LVCMOS33 } [get_ports { eth_mdio }]; #IO_L16P_T2_35 U8-15
#set_property -dict { PACKAGE_PIN G4     IOSTANDARD LVCMOS33 } [get_ports { eth_mdc }]; #IO_L16N_T2_35 U8-16
#set_property -dict { PACKAGE_PIN C7     IOSTANDARD LVCMOS33 } [get_ports { eth_txer }]; #IO_L5P_T0_AD13P_35 U8-17
#set_property -dict { PACKAGE_PIN C6     IOSTANDARD LVCMOS33 } [get_ports { eth_txd[7] }]; #IO_L5N_T0_AD13N_35 U8-18
#set_property -dict { PACKAGE_PIN D6     IOSTANDARD LVCMOS33 } [get_ports { eth_txd[6] }]; #IO_L6P_T0_35 U8-19
#set_property -dict { PACKAGE_PIN D5     IOSTANDARD LVCMOS33 } [get_ports { eth_txd[5] }]; #IO_L6N_T0_VREF_35 U8-20
#set_property -dict { PACKAGE_PIN A5     IOSTANDARD LVCMOS33 } [get_ports { eth_txd[4] }]; #IO_L3P_T0_DQS_AD5P_35 U8-21
#set_property -dict { PACKAGE_PIN A4     IOSTANDARD LVCMOS33 } [get_ports { eth_txclk }]; #IO_L3N_T0_DQS_AD5N_35 U8-22
#set_property -dict { PACKAGE_PIN B4     IOSTANDARD LVCMOS33 } [get_ports { eth_txd[3] }]; #IO_L4P_T0_35 U8-23
#set_property -dict { PACKAGE_PIN A3     IOSTANDARD LVCMOS33 } [get_ports { eth_txd[2] }]; #IO_L4N_T0_35 U8-24
#set_property -dict { PACKAGE_PIN D4     IOSTANDARD LVCMOS33 } [get_ports { eth_txd[1] }]; #IO_L12P_T1_MRCC_35 U8-25
#set_property -dict { PACKAGE_PIN C4     IOSTANDARD LVCMOS33 } [get_ports { eth_rstb }]; #IO_L12N_T1_MRCC_35 U8-26
#set_property -dict { PACKAGE_PIN C3     IOSTANDARD LVCMOS33 } [get_ports { eth_txd[0] }]; #IO_L7P_T1_AD6P_35 U8-27
#set_property -dict { PACKAGE_PIN C2     IOSTANDARD LVCMOS33 } [get_ports { eth_txen }]; #IO_L7N_T1_AD6N_35 U8-28
#set_property -dict { PACKAGE_PIN B2     IOSTANDARD LVCMOS33 } [get_ports { eth_gtx }]; #IO_L8P_T1_AD14P_35 U8-29
#set_property -dict { PACKAGE_PIN A2     IOSTANDARD LVCMOS33 } [get_ports { eth_crs }]; #IO_L8N_T1_AD14N_35 U8-30
#set_property -dict { PACKAGE_PIN C1     IOSTANDARD LVCMOS33 } [get_ports { eth_col }]; #IO_L9P_T1_DQS_AD7P_35 U8-31
#set_property -dict { PACKAGE_PIN B1     IOSTANDARD LVCMOS33 } [get_ports { eth_rxer }]; #IO_L9N_T1_DQS_AD7N_35 U8-32
#set_property -dict { PACKAGE_PIN E2     IOSTANDARD LVCMOS33 } [get_ports { eth_rxd[7] }]; #IO_L10P_T1_AD15P_35 U8-33
#set_property -dict { PACKAGE_PIN D1     IOSTANDARD LVCMOS33 } [get_ports { eth_rxd[6] }]; #IO_L10N_T1_AD15N_35 U8-34
#set_property -dict { PACKAGE_PIN E3     IOSTANDARD LVCMOS33 } [get_ports { eth_rxd[5] }]; #IO_L11P_T1_SRCC_35 U8-35
#set_property -dict { PACKAGE_PIN D3     IOSTANDARD LVCMOS33 } [get_ports { eth_rxd[4] }]; #IO_L11N_T1_SRCC_35 U8-36
#set_property -dict { PACKAGE_PIN F5     IOSTANDARD LVCMOS33 } [get_ports { eth_rxclk }]; #IO_L13P_T2_MRCC_35 U8-37
#set_property -dict { PACKAGE_PIN E5     IOSTANDARD LVCMOS33 } [get_ports { eth_rxd[3] }]; #IO_L13N_T2_MRCC_35 U8-38
#set_property -dict { PACKAGE_PIN F2     IOSTANDARD LVCMOS33 } [get_ports { eth_rxd[2] }]; #IO_L15P_T2_DQS_35 U8-39
#set_property -dict { PACKAGE_PIN E1     IOSTANDARD LVCMOS33 } [get_ports { eth_rxd[1] }]; #IO_L15N_T2_DQS_35 U8-40
#set_property -dict { PACKAGE_PIN F4     IOSTANDARD LVCMOS33 } [get_ports { eth_rxd[0] }]; #IO_L14P_T2_SRCC_35 U8-41
#set_property -dict { PACKAGE_PIN F3     IOSTANDARD LVCMOS33 } [get_ports { eth_rxdv }]; #IO_L14N_T2_SRCC_35 U8-42
