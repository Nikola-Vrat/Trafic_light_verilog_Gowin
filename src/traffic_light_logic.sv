module traffic_light (
    input logic clk,
    output logic led_red, 
    output logic led_yellow, 
    output logic led_green
);

//тактовая частота Tang Nano 4K

localparam integer CLK_FREQUENCY = 27_000_000;

localparam integer RED_TIME = 5;
localparam integer YELLOW_TIME = 2;
localparam integer GREEN_TIME = 5;

localparam logic [1:0] RED = 2'b00;
localparam logic [1:0] YELLOW = 2'b01;
localparam logic [1:0] GREEN = 2'b10;

logic[0:1] state;

//Счетчик тактов
logic[27:0] tacts;

initial begin
    state = RED;
    tacts = 0;
end
always_ff @(posedge clk) begin
    
    case(state)

        RED:begin
            if(tacts == CLK_FREQUENCY * RED_TIME - 1)begin
                tacts <= 0;
                state <= GREEN;
            end else begin
                tacts <= tacts + 28'd1;
            end
        end

        YELLOW:begin
            if(tacts == CLK_FREQUENCY * YELLOW_TIME - 1)begin
                tacts <= 0;
                state <= RED;
            end else begin
                tacts <= tacts + 28'd1;
            end
        end

        GREEN:begin
            if(tacts == CLK_FREQUENCY * GREEN_TIME - 1)begin
                tacts <=0;
                state <= YELLOW;
            end else begin
                tacts <= tacts + 28'd1;
            end
        end

        default: begin
            state <= RED;
            tacts <= 0;
        end
    endcase
end

always_comb begin

    led_red = 1'b0;
    led_green = 1'b0;
    led_yellow = 1'b0;
    
    case(state)

        RED:begin
            led_red = 1'b1;
        end

        GREEN:begin
            led_green = 1'b1;
        end

        YELLOW:begin
            led_yellow = 1'b1;
        end
        default:begin
            led_green = 1'b0;
            led_red = 1'b0;
            led_yellow = 1'b0;
        end

    endcase
end

endmodule