# Step 1:  Read in the source file
analyze -format sverilog -lib WORK {flex_pio_si.sv USB_Timer.sv flex_counter.sv flex_pts_sr.sv bit_stuff.sv Byte_Register.sv Encoder.sv byte_transmitter.sv txpu.sv CRC_Calculator.sv  transmitter.sv receiver.sv decode.sv edge_detect.sv eop_detect.sv flex_stp_sr.sv shift_register.sv sync.sv rxpu.sv usb_receiver.sv rx_fifo.sv rcu.sv timer.sv transceiver.sv}
elaborate transceiver -lib WORK
uniquify
# Step 2: Set design constraints
# Uncomment below to set timing, area, power, etc. constraints
# set_max_delay <delay> -from "<input>" -to "<output>"
# set_max_area <area>
# set_max_total_power <power> mW


# Step 3: Compile the design
compile -map_effort medium

# Step 4: Output reports
report_timing -path full -delay max -max_paths 30 -nworst 1 > reports/transceiver.rep
report_area >> reports/transceiver.rep
report_power -hier >> reports/transceiver.rep

# Step 5: Output final VHDL and Verilog files
write_file -format verilog -hierarchy -output "mapped/transceiver.v"
echo "\nScript Done\n"
echo "\nChecking Design\n"
check_design
quit
