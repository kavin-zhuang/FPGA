module DigitalTube
  (
  iCLK, iRSTn,
  oDigTubeSel,
  oDigTubeValue
  );

  input iCLK;
  input iRSTn;
  output [5:0] oDigTubeSel;
  output [7:0] oDigTubeValue;
  
  parameter DIGITAL0 = 8'b1100_0000, DIGITAL1 = 8'b1111_1001,
            DIGITAL2 = 8'b1010_0100, DIGITAL3 = 8'b1011_0000,
            DIGITAL4 = 8'b1001_1001, DIGITAL5 = 8'b1001_0010,
            DIGITAL6 = 8'b1000_0010, DIGITAL7 = 8'b1111_1000,
            DIGITAL8 = 8'b1000_0000, DIGITAL9 = 8'b1001_0000,
            DIGITAL_OFF = 8'b1111_1111;
        
  parameter T1S = 32'd50_000_000;
  parameter T500MS = 32'd25_000_000;
  parameter T200MS = 32'd10_000_000;
  parameter T100MS = 32'd5_000_000;
  
  reg [32:0] rDelay;
  reg rDelayComplete;
  
  always @ (posedge iCLK or negedge iRSTn)
    if(!iRSTn)
      begin
        rDelay <= 32'd0;
        rDelayComplete <= 1'b0;
      end
    else if(T500MS == rDelay)
      begin
        rDelay <= 32'd0;
        rDelayComplete <= 1'b1;
      end
    else
      begin
        rDelay <= rDelay + 1;
        rDelayComplete <= 1'b0;
      end
    
  reg [3:0] rCounter;
  reg [7:0] rValue;
  
  always @ (posedge iCLK or negedge iRSTn)
    if(!iRSTn)
        begin
          rCounter <= 4'd0;
          rValue <= DIGITAL0;
        end
    else
      begin
        if(rDelayComplete)
          begin
          if(4'd9 == rCounter)
            rCounter <= 0;
          else
            rCounter <= rCounter + 1;
          end
        
        case(rCounter)
          4'd0: rValue <= DIGITAL0;
          4'd1: rValue <= DIGITAL1;
          4'd2: rValue <= DIGITAL2;
          4'd3: rValue <= DIGITAL3;
          4'd4: rValue <= DIGITAL4;
          4'd5: rValue <= DIGITAL5;
          4'd6: rValue <= DIGITAL6;
          4'd7: rValue <= DIGITAL7;
          4'd8: rValue <= DIGITAL8;
          4'd9: rValue <= DIGITAL9;
        endcase
      end
  
  assign oDigTubeSel = 6'b00_0000;
  assign oDigTubeValue = rValue;
  
endmodule
