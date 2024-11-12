module top(
    input logic clk,
    input logic rst,
    input logic trigger,
    input logic[7:0] n,
    output logic[7:0] data_out
);
    logic cmd_seq_in;
    logic cmd_delay_in;
    logic en;
    logic tick_in;
    logic delay_in;
    logic[6:0] random_in;

clktick myclktick(
    .N(n),
    .en(cmd_seq_in),
    .rst(rst),
    .clk(clk),
    .tick(tick_in)
);


lfsr_7 mylfsr(
    .clk(clk),
    .rst(rst),
    .data_out(random_in)
);

delay #(7) mydelay(
    .n(random_in),
    .trigger(cmd_delay_in),
    .rst(rst),
    .clk(clk),
    .time_out(delay_in)
);


assign en = cmd_seq_in ? tick_in:delay_in;


f1_fsm myf1_fsm(
    .rst(rst),
    .en(en),
    .clk(clk),
    .trigger(trigger),
    .cmd_delay(cmd_delay_in),
    .cmd_seq(cmd_seq_in),
    .data_out(data_out)
);

endmodule
