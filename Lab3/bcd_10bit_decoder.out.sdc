## Generated SDC file "bcd_10bit_decoder.out.sdc"

## Copyright (C) 2024  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and any partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details, at
## https://fpgasoftware.intel.com/eula.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 23.1std.1 Build 993 05/14/2024 SC Lite Edition"

## DATE    "Sun Oct 13 23:07:56 2024"

##
## DEVICE  "5CSEMA5F31C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {actual_clock} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLOCK}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {actual_clock}]  1.000 [get_ports {A}]
set_input_delay -add_delay  -clock [get_clocks {actual_clock}]  1.000 [get_ports {B}]
set_input_delay -add_delay  -clock [get_clocks {actual_clock}]  1.000 [get_ports {C}]
set_input_delay -add_delay  -clock [get_clocks {actual_clock}]  1.000 [get_ports {D}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {actual_clock}]  1.000 [get_ports {E}]
set_output_delay -add_delay  -clock [get_clocks {actual_clock}]  1.000 [get_ports {F}]
set_output_delay -add_delay  -clock [get_clocks {actual_clock}]  1.000 [get_ports {G}]
set_output_delay -add_delay  -clock [get_clocks {actual_clock}]  1.000 [get_ports {H}]
set_output_delay -add_delay  -clock [get_clocks {actual_clock}]  1.000 [get_ports {L}]
set_output_delay -add_delay  -clock [get_clocks {actual_clock}]  1.000 [get_ports {M}]
set_output_delay -add_delay  -clock [get_clocks {actual_clock}]  1.000 [get_ports {N}]
set_output_delay -add_delay  -clock [get_clocks {actual_clock}]  1.000 [get_ports {O}]
set_output_delay -add_delay  -clock [get_clocks {actual_clock}]  1.000 [get_ports {P}]
set_output_delay -add_delay  -clock [get_clocks {actual_clock}]  1.000 [get_ports {Q}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

