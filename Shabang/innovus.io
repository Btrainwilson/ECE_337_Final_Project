# This file specifies how the pads are placed
# The name of each pad here has to match the
# name in the verilog code
# The target padframe has 4 corners cells and 40 side pads
# Each side should have at least 1 vdd/gnd pair
# Use filler cells (PADNC) to fill up each side to 10 pads each
# Each pad instance needs it's orientation specified

Version: 2

Orient: R0
Pad: co1 NW PADFC
Orient: R270
Pad: co2 NE PADFC
Orient: R90
Pad: co3 SW PADFC
Orient: R180
Pad: co4 SE PADFC




#-----------------------------------------------North Pads----------------------------------


#------------Left Pads--------------
Orient: R0
Pad: NL01 N PADNC
Orient: R0
Pad: NL02 N PADNC
Orient: R0
Pad: NL03 N PADNC
Orient: R0
Pad: NL04 N PADNC
Orient: R0
Pad: NL05 N PADNC
Orient: R0
Pad: NL06 N PADNC
Orient: R0
Pad: NL07 N PADNC
Orient: R0
Pad: NL08 N PADNC
Orient: R0
Pad: U1 N PADOUT 		#------U1-----
Orient: R0
Pad: NL10 N PADNC
Orient: R0
Pad: NL11 N PADNC
Orient: R0
Pad: NL12 N PADNC
Orient: R0
Pad: NL13 N PADNC
Orient: R0
Pad: NL14 N PADNC
Orient: R0
Pad: NL15 N PADNC
Orient: R0
Pad: NL16 N PADNC




#---------------Power and Ground Pads------------
Orient: R0
Pad: G0 N PADGND
Orient: R0
Pad: P0 N PADVDD


#------------Right Pads-------------

Orient: R0
Pad: NR01 N PADNC
Orient: R0
Pad: NR02 N PADNC
Orient: R0
Pad: NR03 N PADNC
Orient: R0
Pad: NR04 N PADNC
Orient: R0
Pad: NR05 N PADNC
Orient: R0
Pad: NR06 N PADNC
Orient: R0
Pad: NR07 N PADNC
Orient: R0
Pad: NR08 N PADNC
Orient: R0
Pad: U4 N PADINC		#------U4-----
Orient: R0
Pad: NR10 N PADNC
Orient: R0
Pad: NR11 N PADNC
Orient: R0
Pad: NR12 N PADNC
Orient: R0
Pad: NR13 N PADNC
Orient: R0
Pad: NR14 N PADNC
Orient: R0
Pad: NR15 N PADNC
Orient: R0
Pad: NR16 N PADNC





#-----------------------------------------------West Pads----------------------------------


#------------Left Pads--------------

Orient: R90
Pad: WL01 W PADNC
Orient: R90
Pad: WL02 W PADNC
Orient: R90
Pad: WL03 W PADNC
Orient: R90
Pad: WL04 W PADNC
Orient: R90
Pad: U2 W PADOUT	#------U2-----
Orient: R90
Pad: WL06 W PADNC
Orient: R90
Pad: WL07 W PADNC
Orient: R90
Pad: WL08 W PADNC
Orient: R90
Pad: WL09 W PADNC
Orient: R90
Pad: WL10 W PADNC
Orient: R90
Pad: WL11 W PADNC
Orient: R90
Pad: U3 W PADOUT 	#------U3-----
Orient: R90
Pad: WL13 W PADNC
Orient: R90
Pad: WL14 W PADNC
Orient: R90
Pad: WL15 W PADNC
Orient: R90
Pad: WL16 W PADNC


#---------------Power and Ground Pads------------
Orient: R90
Pad: P1 W PADVDD
Orient: R90
Pad: G1 W PADGND



#------------Right Pads-------------

Orient: R90
Pad: WR01 W PADNC
Orient: R90
Pad: WR02 W PADNC
Orient: R90
Pad: WR03 W PADNC
Orient: R90
Pad: WR04 W PADNC
Orient: R90
Pad: WR05 W PADNC
Orient: R90
Pad: WR06 W PADNC
Orient: R90
Pad: U9 W PADNC		#------U9-----
Orient: R90
Pad: WR08 W PADNC
Orient: R90
Pad: WR09 W PADNC
Orient: R90
Pad: WR10 W PADNC
Orient: R90
Pad: WR11 W PADNC
Orient: R90
Pad: WR12 W PADNC
Orient: R90
Pad: WR13 W PADNC
Orient: R90
Pad: WR14 W PADNC
Orient: R90
Pad: WR15 W PADNC
Orient: R90
Pad: WR16 W PADNC



#-----------------------------------------------South Pads----------------------------------


#------------Left Pads--------------

Orient: R180
Pad: SL01 S PADNC
Orient: R180
Pad: SL02 S PADNC
Orient: R180
Pad: SL03 S PADNC
Orient: R180
Pad: U5 S PADINC	#------U5-----
Orient: R180
Pad: SL05 S PADNC
Orient: R180
Pad: SL06 S PADNC
Orient: R180
Pad: SL07 S PADNC
Orient: R180
Pad: SL08 S PADNC
Orient: R180
Pad: SL09 S PADNC
Orient: R180
Pad: U6 S PADINC	#------U6-----
Orient: R180
Pad: SL11 S PADNC
Orient: R180
Pad: SL12 S PADNC
Orient: R180
Pad: SL13 S PADNC
Orient: R180
Pad: SL14 S PADNC
Orient: R180
Pad: SL15 S PADNC
Orient: R180
Pad: SL16 S PADNC


#---------------Power and Ground Pads------------

Orient: R180
Pad: P2 S PADVDD
Orient: R180
Pad: G2 S PADGND


#------------Right Pads-------------

Orient: R180
Pad: SR01 S PADNC
Orient: R180
Pad: SR02 S PADNC
Orient: R180
Pad: SR03 S PADNC
Orient: R180
Pad: SR04 S PADNC
Orient: R180
Pad: SR05 S PADNC
Orient: R180
Pad: SR06 S PADNC
Orient: R180
Pad: SR07 S PADNC
Orient: R180
Pad: SR08 S PADNC
Orient: R180
Pad: SR09 S PADNC
Orient: R180
Pad: SR10 S PADNC
Orient: R180
Pad: SR11 S PADNC
Orient: R180
Pad: SR12 S PADNC
Orient: R180
Pad: SR13 S PADNC
Orient: R180
Pad: SR14 S PADNC
Orient: R180
Pad: SR15 S PADNC
Orient: R180
Pad: SR16 S PADNC



#-----------------------------------------------East Pads----------------------------------


#------------Left Pads--------------

Orient: R270
Pad: EL01 E PADNC
Orient: R270
Pad: EL02 E PADNC
Orient: R270
Pad: EL03 E PADNC
Orient: R270
Pad: EL04 E PADNC
Orient: R270
Pad: EL05 E PADNC
Orient: R270
Pad: EL06 E PADNC
Orient: R270
Pad: U7 E PADINC		#------U7-----
Orient: R270
Pad: EL08 E PADNC
Orient: R270
Pad: EL09 E PADNC
Orient: R270
Pad: EL10 E PADNC
Orient: R270
Pad: EL11 E PADNC
Orient: R270
Pad: EL12 E PADNC
Orient: R270
Pad: EL13 E PADNC
Orient: R270
Pad: EL14 E PADNC
Orient: R270
Pad: EL15 E PADNC
Orient: R270
Pad: EL16 E PADNC

#---------------Power and Ground Pads------------

Orient: R270
Pad: P3 E PADVDD
Orient: R270
Pad: G3 E PADGND



#------------Right Pads-------------

Orient: R270
Pad: ER01 E PADNC
Orient: R270
Pad: ER02 E PADNC
Orient: R270
Pad: ER03 E PADNC
Orient: R270
Pad: ER04 E PADNC
Orient: R270
Pad: ER05 E PADNC
Orient: R270
Pad: ER06 E PADNC
Orient: R270
Pad: ER07 E PADNC
Orient: R270
Pad: ER08 E PADNC
Orient: R270
Pad: ER09 E PADNC
Orient: R270
Pad: ER10 E PADNC
Orient: R270
Pad: U8 E PADINC		#------U8-----
Orient: R270
Pad: ER12 E PADNC
Orient: R270
Pad: ER13 E PADNC
Orient: R270
Pad: ER14 E PADNC
Orient: R270
Pad: ER15 E PADNC
Orient: R270
Pad: ER16 E PADNC
