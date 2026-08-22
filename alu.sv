// typedef allows for reusable state definitions which in this case is state_t for traffic light states
// enum {} allows for defining a set of string values, which makes the code more readable and maintainable
// logic [1:0] specifies that the enum will use 2 bits to represent the states, allowing for 4 possible values (00, 01, 10, 11) which is sufficient for our three states (RED, GREEN, YELLOW)
typedef enum logic [1:0] {RED, GREEN, YELLOW} state_t; 

    module traffic_light ( //module definition for traffic light controller
        input logic clk, //clock input 0 and 1s
        input logic rst_n, //active low reset input
        output state_t state
    );
        always_ff @(posedge clk) begin // always_ff means flip-flop behavior, triggered on the positive edge of the clock 
            if (!rst_n)                // posedge means the block will execute on the rising edge of the clock signal, which is a common practice in synchronous digital design
                current_state <= RED;
            else case (state)
                RED: current_state <= GREEN;
                GREEN: current_state <= YELLOW;
                YELLOW: current_state <= RED;
                default: current_state <= RED;
            endcase
        end //end to always_ff block
    endmodule