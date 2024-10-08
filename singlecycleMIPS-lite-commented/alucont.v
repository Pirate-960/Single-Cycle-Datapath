module alucont(aluop1,aluop0,f5,f4,f3,f2,f1,f0,gout);//Figure 4.12 
input aluop1,aluop0,f5,f4,f3,f2,f1,f0;
output [2:0] gout;
reg [2:0] gout;
always @(aluop1 or aluop0 or f5 or f4 or f3 or f2 or f1 or f0)
begin
if(~(aluop1|aluop0))gout=3'b010; // LW, SW
if(~aluop1 & aluop0)gout=3'b110; // beq
if(aluop1 & aluop0)gout=3'b011; // Nandi
if(aluop1 & ~aluop0)//R-type
begin
	if (f5 & ~f4 & ~f3 & ~f2 & ~f1 & ~f0)gout=3'b010; //function code=0000,ALU control=010 (add)
	if (f5 & ~f4 & ~f3 & ~f2 & f1 & ~f0)gout=3'b110;//function code=1x1x,ALU control=111 (sub)
	if (f5 & ~f4 & ~f3 & f2 & ~f1 & ~f0)gout=3'b000;//function code=0x10,ALU control=110 (and)
	if (f5 & ~f4 & ~f3 & f2 & ~f1 & f0)gout=3'b001;	//function code=x1x1,ALU control=001 (or)
	if (f5 & ~f4 & f3 & ~f2 & f1 & ~f0)gout=3'b111;	//function code=x1x0,ALU control=000 (slt)
	if (f5 & ~f4 & ~f3 & f2 & f1 & f0)gout=3'b100;	//function code=x1x0,ALU control=000 (nor)
	if (~f5 & f4 & ~f3 & f2 & ~f1 & f0)gout=3'b010;	//function code=x1x0,ALU control=000 (brnv)
end
end
endmodule
