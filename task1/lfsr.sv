module lfsr(
    input   logic       clk,  //clk
    input   logic       rst,  //reset 
    input   logic       en,   //enable
    output  logic [4:1] data_out //PRBS (pseudo random binary output)
);

logic[4:1] sreg;

always_ff @(posedge clk, posedge rst)
    if(rst) sreg <= 4'b1;
    else if(en) sreg <= {sreg[3:1], sreg[4] ^ sreg[3]}; //perform shift and logic for last bit.

assign data_out = sreg;

endmodule
