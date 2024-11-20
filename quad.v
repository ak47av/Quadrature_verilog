module quad(input clk, input dir, input reset, output reg A, output reg B);

    parameter PULSE_WIDTH = 2;
    reg[9:0] clk_count=0;
    reg width_clk=0;

    parameter UP0 = 3'b000, UP1 = 3'b001, UP2 = 3'b010, UP3 = 3'b011;
    parameter DOWN0 = 3'b100, DOWN1 = 3'b101, DOWN2 = 3'b110, DOWN3 = 3'b111;
    reg[2:0] state, next_state;

    always @(posedge clk) begin
        if(clk_count < (PULSE_WIDTH-1)/2) clk_count <= clk_count + 1;
        else begin
            clk_count <= 0;
            width_clk <= ~width_clk;
        end
    end

    always @(posedge clk) begin
        case(state)
            UP0: next_state <= (dir==1)? DOWN0:UP1;
            UP1: next_state <= (dir==1)? DOWN0:UP2;
            UP2: next_state <= (dir==1)? DOWN0:UP3;
            UP3: next_state <= (dir==1)? DOWN0:UP0;
            DOWN0: next_state <= (dir==1)? UP0:DOWN1;
            DOWN1: next_state <= (dir==1)? UP0:DOWN2;
            DOWN2: next_state <= (dir==1)? UP0:DOWN3;
            DOWN3: next_state <= (dir==1)? UP0:DOWN0;
        endcase
    end

    always @(posedge width_clk, posedge reset) begin
        if(reset) state <= UP0;
        else state <= next_state;
    end


    always @(posedge width_clk) begin
        case(state)
            UP0: begin
                A <= 0;
                B <= 0;
            end
            UP1: begin
                A <= 0;
                B <= 1;
            end
            UP2: begin
                A <= 1;
                B <= 1;
            end
            UP3: begin
                A <= 1;
                B <= 0;
            end
            DOWN0: begin
                A <= 0;
                B <= 0;
            end
            DOWN1: begin
                A <= 1;
                B <= 0;
            end
            DOWN2: begin
                A <= 1;
                B <= 1;
            end
            DOWN3: begin
                A <= 0;
                B <= 1;
            end
        endcase
    end
    

endmodule