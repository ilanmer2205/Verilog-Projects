
# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
# Switches
set_property PACKAGE_PIN V17 [get_ports {on}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {on}]


# LEDs
set_property PACKAGE_PIN U16 [get_ports {led}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led}]

set_property PACKAGE_PIN E19 [get_ports {led_check[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_check[0]}]
set_property PACKAGE_PIN U19 [get_ports {led_check[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_check[1]}]
set_property PACKAGE_PIN V19 [get_ports {led_check[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_check[2]}]

##Buttons
set_property PACKAGE_PIN U18 [get_ports rst]						
	set_property IOSTANDARD LVCMOS33 [get_ports rst]



##Pmod Header JA
     ##car traffic lights
##Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {light1[0]}]			
##green		
	set_property IOSTANDARD LVCMOS33 [get_ports {light1[0]}] 
##Sch name = JA2
set_property PACKAGE_PIN L2 [get_ports {light1[1]}]			
##yellow		
	set_property IOSTANDARD LVCMOS33 [get_ports {light1[1]}]
##Sch name = JA3
set_property PACKAGE_PIN J2 [get_ports {light1[2]}]			
##red		
	set_property IOSTANDARD LVCMOS33 [get_ports {light1[2]}]
	
	## passenger traffic lights
##Sch name = JA4  
set_property PACKAGE_PIN G2 [get_ports {light2[0]}]			
##green		
	set_property IOSTANDARD LVCMOS33 [get_ports {light2[0]}]
##Sch name = JA7
set_property PACKAGE_PIN H1 [get_ports {light2[1]}]			  
##red		
	set_property IOSTANDARD LVCMOS33 [get_ports {light2[1]}]
	
	
##Sch name = JA8
#set_property PACKAGE_PIN K2 [get_ports {JA[5]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[5]}]
##Sch name = JA9
#set_property PACKAGE_PIN H2 [get_ports {JA[6]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[6]}]
##Sch name = JA10
#set_property PACKAGE_PIN G3 [get_ports {JA[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[7]}]


