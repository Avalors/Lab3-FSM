module f1_fsm (
    input   logic       rst,
    input   logic       en,
    input   logic       clk,
    input   logic       trigger,
    output  logic       cmd_seq,
    output  logic       cmd_delay,
    output  logic [7:0] data_out
);

    //initilize all states
    typedef enum {S0, S1, S2, S3, S4, S5, S6, S7, S8} mystate;
    mystate current_state, next_state;


    //intantiates state change
    always_ff @(posedge clk, posedge rst)
        if(rst) current_state <= S0;
        else if(en & trigger) current_state <= next_state;

    //sets next_state logic
    always_comb
        case(current_state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S5;
            S5: next_state = S6;
            S6: next_state = S7;
            S7: next_state = S8;
            S8: next_state = S0;
            default next_state = S0;
        endcase

    always_comb
        case(current_state)
            S0: data_out = 8'b0;
            S1: data_out = 8'b1;
            S2: data_out = 8'b11;
            S3: data_out = 8'b111;
            S4: data_out = 8'b1111;
            S5: data_out = 8'b11111;
            S6: data_out = 8'b111111;
            S7: data_out = 8'b1111111;
            S8: data_out = 8'b11111111;
            default data_out = 8'b0;
        endcase

    always_comb
        case(current_state)
            S0: cmd_seq = 1'b0;
            S1: cmd_seq = 1'b1;
            S2: cmd_seq = 1'b1;
            S3: cmd_seq = 1'b1;
            S4: cmd_seq = 1'b1;
            S5: cmd_seq = 1'b1;
            S6: cmd_seq = 1'b1;
            S7: cmd_seq = 1'b1;
            S8: cmd_seq = 1'b1;
            default cmd_seq = 1'b0;
        endcase

        
    always_comb
        case(current_state)
            S0: cmd_delay= 1'b1;
            S1: cmd_delay = 1'b0;
            S2: cmd_delay = 1'b0;
            S3: cmd_delay = 1'b0;
            S4: cmd_delay = 1'b0;
            S5: cmd_delay = 1'b0;
            S6: cmd_delay = 1'b0;
            S7: cmd_delay = 1'b0;
            S8: cmd_delay = 1'b0;
            default cmd_seq = 1'b0;
        endcase

endmodule
