#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

#define MAX_I 100000

int main(int argc, char **argv, char **env){
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);

    Vtop* top = new Vtop;

    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp,99);
    tfp->open("top.vcd");

    //init buddy
    if(vbdOpen() != 1) return(-1);
    vbdHeader("Lab3: FSM");

    //initialize simulation inputs
    top->n = 48;
    top->clk = 1;
    top->rst = 1;
    top->trigger = 0;
    vbdSetMode(0);

    //run simulation for this many clock cycles:
    for(int i = 0; i < 1000; i++){
        
        for(clk = 0; clk < 2; clk++){
            tfp->dump(2*i*clk);
            top->clk = !top->clk;
            top->eval();
        }

        //displays output on neopixel strip
        vbdBar(top->data_out & 0xFF);
        vbdCycle(i+1);

        //change input stimuli
        top->rst = (i < 2);
        top->trigger = vbdFlag();

        if(Verilated::gotFinish() || (vbdGetkey() == 'q')) exit(0);
    }

    vbdClose();
    tfp->close();
    exit(0);
}