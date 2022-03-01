module Clock_Div //Divides Clock by half. I.e 50 MHz Clock will turn into 25 MHz clock.
(
	input i_Clock,
	output o_Clock
);


reg r_Clock = 0;

always @(posedge i_Clock)
	begin
		r_Clock <= ~r_Clock;
	end

assign o_Clock = r_Clock;

endmodule

