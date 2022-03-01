//This module checks for key presses and signals when a key is pressed & released

module Check_Key
#(
	parameter KEY1 = 8'h61, //ASCII Codes of buttons being pressed (LEFT/RIGHT, or UP/DOWN)
	parameter KEY2 = 8'h64
 )

(
	input i_Clock,
	input [7:0] i_ASCII_Code,
	input rx_done_tick,
	
	output o_Key1,
	output o_Key2,
	output o_Space
);

localparam  BREAK    = 8'hf0;
localparam	c_SPACE  = 8'h20;

reg r_Key1 = 0;
reg r_Key2 = 0; 
reg [15:0] r_kbd_data = 0;
reg r_Space;

always @(posedge i_Clock)
begin
	if(rx_done_tick == 1'b1)
	r_kbd_data <= {r_kbd_data[7:0], i_ASCII_Code[7:0]};			// Save data at rx_done_tick, save it byte by byte
	else
	r_kbd_data <= r_kbd_data;
end

always @(posedge i_Clock)
	begin
		if (r_kbd_data[7:0] == KEY1 && r_kbd_data[15:8] == BREAK) // Check for break code F0 and key to signal that button is lifted, only stop moving when button is lifted
					r_Key1 <= 1'b0;
		else
			begin
			if (r_kbd_data[7:0] == KEY1)
					r_Key1 <= 1'b1;
			end
	end

always @(posedge i_Clock)
	begin
		if (r_kbd_data[7:0] == KEY2 && r_kbd_data[15:8] == BREAK) // Check for break code F0 and key to signal that button is lifted, only stop moving when button is lifted
					r_Key2 <= 1'b0;
		else
			begin
			if (r_kbd_data[7:0] == KEY2)
					r_Key2 <= 1'b1;
			end
	end

//Check to see if the space bar is pressed and released. This is to start the game.	
always @(posedge i_Clock)
	begin
		if (r_kbd_data[7:0] == c_SPACE && r_kbd_data[15:8] == BREAK) //Check for break code F0 and key to signal that button is lifted, only stop moving when button is lifted
					r_Space <= 1'b1;
		else
					r_Space <= 1'b0;

	end
	
assign o_Key1 = r_Key1;
assign o_Key2 = r_Key2;
assign o_Space = r_Space;
endmodule
