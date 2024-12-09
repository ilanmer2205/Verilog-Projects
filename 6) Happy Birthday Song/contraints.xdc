
# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 

##Pmod Header JA
##Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {sound}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sound}]

# Switches
set_property PACKAGE_PIN V17 [get_ports {on}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {on}]



