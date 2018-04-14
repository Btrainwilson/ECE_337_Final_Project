# Step 1:  Read in the source file
analyze -format sverilog -lib WORK {ERCU.sv Decoder.sv Counter.sv edge_detect.sv shift_register.sv Timer.sv sync_high.sv flex_counter.sv flex_stp_sr.sv Packet_Processor.sv}
elaborate Packet_Processor -lib WORK
uniquify
# Step 2: Set design constraints
# Uncomment below to set timing, area, power, etc. constraints
# set_max_delay <delay> -from "<input>" -to "<output>"
# set_max_area <area>
# set_max_total_power <power> mW


# Step 3: Compile the design
compile -map_effort medium

# Step 4: Output reports
report_timing -path full -delay max -max_paths 1 -nworst 1 > reports/Packet_Processor.rep
report_area >> reports/Packet_Processor.rep
report_power -hier >> reports/Packet_Processor.rep

# Step 5: Output final VHDL and Verilog files
write_file -format verilog -hierarchy -output "mapped/Packet_Processor.v"
echo "\nScript Done\n"
echo "\nChecking Design\n"
check_design
quit
