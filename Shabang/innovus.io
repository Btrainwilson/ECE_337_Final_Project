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
Pad: D21 N PADNC

Pad: D0 N PADNC

Pad: U3 N PADOUT

Pad: D1 N PADNC

Pad: P0 N PADVDD

Pad: D24 N PADNC

Pad: D23 N PADNC

Pad: G0 N PADGND

Pad: D2 N PADNC

Pad: U4 N PADINC

Pad: D3 N PADNC

Pad: D22 N PADNC


Orient: R90
Pad: D20 W PADNC

Pad: D4 W PADNC

Pad: U1 W PADOUT

Pad: D5 W PADNC

Pad: P1 W PADVDD
Pad: D25 W PADNC

Pad: D26 W PADNC
Pad: G1 W PADGND

Pad: D6 W PADNC

Pad: D13 W PADOUT

Pad: D7 W PADNC

Pad: D19 W PADNC



Orient: R180
Pad: D17 S PADNC

Pad: D8 S PADNC

Pad: U6 S PADINC

Pad: D9 S PADNC

Pad: P2 S PADVDD
Pad: D27 S PADNC

Pad: D28 S PADNC
Pad: G2 S PADGND

Pad: D10 S PADNC

Pad: U2 S PADINC

Pad: D11 S PADNC

Pad: D18 S PADNC


Orient: R270
Pad: D16 E PADNC

Pad: D12 E PADNC

Pad: U7 E PADINC

Pad: U5 E PADNC

Pad: P3 E PADVDD

Pad: D29 N PADNC

Pad: D30 N PADNC

Pad: G3 E PADGND

Pad: D14 E PADNC

Pad: U8 E PADINC

Pad: D15 E PADNC

Pad: U9 E PADINC









