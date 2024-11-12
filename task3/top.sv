module top(
    input logic[15:0] n,
    input logic clk,
    input logic en,
    input logic rst,
    output logic [7:0] data_out
);

logic ien;

clktick timer(
    .clk(clk),
    .rst(rst),
    .en(en),
    .N(n),
    .tick(ien)
);

f1_fsm timed_f1_fsm(
    .clk(clk),
    .en(ien),
    .rst(rst),
    .data_out(data_out)
);

endmodule
