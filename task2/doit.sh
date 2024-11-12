#!/bin/sh

#vbuddy connection established
~/Documents/iac/lab0-devtools/tools/attach_usb.sh

#cleanup
rm -rf obj_dir
rm -f f1_fsm.vcd

#verilator that generates mk file and Vcounter.cpp file 
verilator -Wall --cc --trace f1_fsm.sv -exe f1_fsm_tb.cpp

#compiles mk file and cpp file into executable model of digital design
make -j -C obj_dir/ -f Vf1_fsm.mk Vf1_fsm

#run executable file
obj_dir/Vf1_fsm