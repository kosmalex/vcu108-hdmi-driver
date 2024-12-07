quit -sim
file delete -force work

vlib work

vlog -f files_rtl.f -f files_sim.f

#vsim -novopt work.tb -onfinish "stop"
# Option -novopt deprecated in newer versions
vsim -voptargs="+acc" tb -onfinish "stop"

mem load -infile ../mem/i2c_rom.mem -format hex -filltype value -filldata 16'Hbeef /tb/dut/i2c_controller/i2c_rom_0

log -r /*
do wave.do
#onbreak {wave zoom full}
run 1000us
#wave zoom full
