module UART(CLK, RSTn, oTxPin);

	input CLK;
	input RSTn;
	output oTxPin;
	
	/* const value */
	parameter BPS9600 = 32'd5208;
	
	reg [31:0] counter;
  reg rTxPin;
	
	always @ (posedge CLK or negedge RSTn)
		if(!RSTn)
			counter <= 32'd0;
		else if(BPS9600 == counter)
      begin
        counter <= 32'd0;
        if(rTxPin)
          rTxPin <= 1'b0;
        else
          rTxPin <= 1'b1;
      end
		else
			counter <= counter + 1'b1;
      
	assign oTxPin = rTxPin;
	
endmodule
