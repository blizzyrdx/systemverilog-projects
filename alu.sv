// typedef allows for reusable state definitions which in this case is state_t for traffic light states
// enum {} allows for defining a set of string values, which makes the code more readable and maintainable
// logic [1:0] specifies that the enum will use 2 bits to represent the states, allowing for 4 possible values (00, 01, 10, 11) which is sufficient for our three states (RED, GREEN, YELLOW)
typedef enum logic [1:0] {RED, GREEN, YELLOW} state_t; 

    module traffic_light ( //module definition for traffic light controller
        input logic clk, //clock input 0 and 1s
        input logic rst, //active low reset input
        output state_t state
    );
        always_ff @(posedge clk) begin // always_ff means flip-flop behavior, triggered on the positive edge of the clock 
            if (rst)                // posedge means the block will execute on the rising edge of the clock signal, which is a common practice in synchronous digital design
                state <= RED;
            else case (state)
                RED: state <= GREEN;
                GREEN: state <= YELLOW;
                YELLOW: state <= RED;
                default: state <= RED;
            endcase
        end //end to always_ff block
    endmodule

// Challenge 1: Update the state_t enum to include an additional state called ALL_RED, which represents a state where all traffic lights are red. This will require modifying the enum definition and updating the state transition logic in the always_ff block to include this new state. 
typedef enum logic [1:0] {RED, GREEN, YELLOW, ALL_RED} state_t; 

    module traffic_light ( //module definition for traffic light controller
        input logic clk, //clock input 0 and 1s
        input logic rst, //active low reset input
        output state_t state
    );
        always_ff @(posedge clk) begin // always_ff means flip-flop behavior, triggered on the positive edge of the clock 
            if (rst)                // posedge means the block will execute on the rising edge of the clock signal, which is a common practice in synchronous digital design
                state <= RED;
            else case (state)
                RED: state <= GREEN;
                GREEN: state <= YELLOW;
                YELLOW: state <= ALL_RED;
                ALL_RED: state <= RED;
            endcase
        end //end to always_ff block
    endmodule

// Challenge 2: Write a short SystemVerilog testbench that instantiates traffic_light_sv, generates a clock, pulses rst, and prints the state name each cycle.
module tb_traffic_light ();
    logic clk, rst;
    state_t state; //previous state_t definition is used here to declare the state variable

    traffic_light_sv dut (.clk(clk), .rst(rst), .state(state)); //dut is design-under-test

    always #10 clk = ~clk; // clock generation, toggles clk every 10 time units, ~ is bitwise NOT operator, so it inverts the clk signal
 
    initial begin
        clk = 0; rst = 1;
        #20 rst = 0;
        repeat (4) begin
            @ (posedge clk);
            $display("time=%0t state=%s", $time, state.name());
        end
    end
endmodule

// Challenge 2: Modified testbench to have finish
`timescale 1ns/1ps

module tb_traffic_light;

    logic clk;
    logic rst;
    state_t state;

    traffic_light_sv dut (
        .clk   (clk),
        .rst   (rst),
        .state (state)
    );

    always #10 clk = ~clk;

    initial begin
        clk = 1'b0;
        rst = 1'b1;

        #20;
        rst = 1'b0;

        repeat (4) begin
            @(posedge clk);
            $strobe("time=%0t state=%s", $time, state.name());
        end

        #1;
        $finish; //added finish to end the simulation after 4 cycles
    end

endmodule