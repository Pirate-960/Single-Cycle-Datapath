module alu32(sum, a, b, zout, gin, Nin, Vin);//ALU operation according to the ALU control line values
output [31:0] sum;
input [31:0] a,b; 
input [2:0] gin;//ALU control line

reg [31:0] sum;
reg [31:0] less;

output zout;
output Nin, Vin;

reg zout;
reg Nin, Vin;

always @(a or b or gin)
begin
	case(gin)
	3'b010: sum=a+b; 		//ALU control line=010, ADD
	3'b110: sum=a+1+(~b);	//ALU control line=110, SUB
	3'b111: begin less=a+1+(~b);	//ALU control line=111, set on less than
			if (less[31]) sum=1;	
			else sum=0;
		  end
	3'b000: sum=a & b;	//ALU control line=000, AND
	3'b001: sum=a|b;		//ALU control line=001, OR
	
	3'b100: sum = ~(a | b); // ALU control line = 100, NOR
        3'b011: sum = ~(a & b); // ALU control line = 011, NAND
	default: sum=31'bx;	
	endcase

	zout=~(|sum); // Zin
	Nin = sum[31]; // negative flag: 1 if result is negative

	// overflow detect
	case (gin)
      	3'b010: // ADD overflow detection
        	Vin = (a[31] & b[31] & ~sum[31]) | (~a[31] & ~b[31] & sum[31]);
      	3'b110: // SUB overflow detection
        	Vin = (a[31] & ~b[31] & ~sum[31]) | (~a[31] & b[31] & sum[31]);
      	default:
        	Vin = 0;
    	endcase

end
endmodule
