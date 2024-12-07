onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/dut/clk_i
add wave -noupdate /tb/dut/rst_n_i
add wave -noupdate /tb/dut/pixel_clk_i
add wave -noupdate /tb/dut/vs_o
add wave -noupdate /tb/dut/hs_o
add wave -noupdate /tb/dut/ad_o
add wave -noupdate /tb/dut/scl_o
add wave -noupdate /tb/dut/sda_io
add wave -noupdate -expand -group I2C_Controller -expand -group I2C /tb/dut/i2c_controller/i2c_0/send_i
add wave -noupdate -expand -group I2C_Controller -expand -group I2C /tb/dut/i2c_controller/i2c_0/nbytes_i
add wave -noupdate -expand -group I2C_Controller -expand -group I2C /tb/dut/i2c_controller/i2c_0/data_i
add wave -noupdate -expand -group I2C_Controller -expand -group I2C /tb/dut/i2c_controller/i2c_0/data_o
add wave -noupdate -expand -group I2C_Controller -expand -group I2C /tb/dut/i2c_controller/i2c_0/done_o
add wave -noupdate -expand -group I2C_Controller -expand -group I2C /tb/dut/i2c_controller/i2c_0/ready_o
add wave -noupdate -expand -group I2C_Controller -expand -group I2C /tb/dut/i2c_controller/i2c_0/scl_o
add wave -noupdate -expand -group I2C_Controller -expand -group I2C /tb/dut/i2c_controller/i2c_0/sda_io
add wave -noupdate -expand -group I2C_Controller /tb/dut/i2c_controller/i2c_0/is_read_s
add wave -noupdate -expand -group I2C_Controller /tb/dut/start_1cc_i
add wave -noupdate -expand -group I2C_Controller /tb/dut/i2c_controller/st
add wave -noupdate -expand -group I2C_Controller /tb/dut/i2c_controller/i2c_send_s
add wave -noupdate -expand -group I2C_Controller /tb/dut/i2c_controller/i2c_nbytes_s
add wave -noupdate -expand -group I2C_Controller /tb/dut/i2c_controller/i2c_done_s
add wave -noupdate -expand -group I2C_Controller /tb/dut/i2c_controller/i2c_trans_cnt_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {121105000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 274
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {338207735 ps}
