// Moves the position of the paddle if a button is pressed for 1 Dimension. Outputs the position of the paddle in Pixel location.

module Paddle_Position
#( parameter pos_MAX,
	parameter pos_MIN,
	parameter origin,
	parameter Paddle_Speed
 )
(
	input         i_Clock,
	input  [1:0]  i_Switch,
	output [10:0] o_New_Pos
);


reg  [31:0] r_Count = 0;
reg  [31:0] r_Count_Inv = 0;
reg  [10:0] r_Pos = origin;								// Initialize at origin
wire        w_En;


assign w_En = i_Switch[0] ^ i_Switch[1];

always @(posedge i_Clock)
begin

	if(w_En == 1'b1) 											// Only move when 1 button is pressed, not both
		begin
		
			if(i_Switch[0] == 1'b1)
				begin
				
					if(r_Count == Paddle_Speed)
						begin
							r_Count <= 0;
							if (r_Pos <= pos_MAX)
																	// Move Right or Up, positive direction until MAX, and then pause if max.
								r_Pos <= r_Pos + 1;
						end
						
					else
						r_Count <= r_Count + 1; 			// If paddle counter not hit, increment counter and stay at same position.
				end
				
			else if (i_Switch[1] == 1'b1)  				// Other Direction is pressed
				begin
				
					if(r_Count_Inv == Paddle_Speed)
						begin
							r_Count_Inv <= 0;
							if (r_Pos > pos_MIN) 
																	// Move Left or Down, negative direction
								r_Pos <= r_Pos - 1;
						end
						
						
					else
						r_Count_Inv <= r_Count_Inv + 1; 	// Increment counter and stay at position.
				end

		end

end

assign o_New_Pos = r_Pos;
endmodule
