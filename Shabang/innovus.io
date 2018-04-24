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


Orient: R0
Pad: U3 N PADOUT
Orient: R0
Pad: P0 N PADVDD
Orient: R0
Pad: G0 N PADGND
Orient: R0
Pad: U4 N PADINC





Orient: R90
Pad: U1 W PADOUT
Orient: R90
Pad: P1 W PADVDD
Orient: R90
Pad: G1 W PADGND
Orient: R90
OPad: U2 W PADOUT



Orient: R180
Pad: U5 S PADINC
Orient: R180
Pad: P2 S PADVDD
Orient: R180
Pad: G2 S PADGND
Orient: R180
Pad: U6 S PADINC


Orient: R270
Pad: U7 E PADINC
Orient: R270
Pad: P3 E PADVDD
Orient: R270
Pad: G3 E PADGND
Orient: R270
Pad: U8 E PADINC
Orient: R270
Pad: U9 E PADINC









