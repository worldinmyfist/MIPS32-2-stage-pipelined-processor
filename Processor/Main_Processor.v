`timescale 1ns / 1ps

module loc_control(input flagi, input [3:0]aluctri, input sign, input [5:0]func, input aluop, output [3:0]aluctr ,output flag_out, output extop);
reg [3:0]temp;
reg flag;
always@(*)
	begin
	case(func) 
				6'b100000://add
				begin
				temp <= 4'b0000;
				flag = 0;
				end
				6'b100100://and
				begin
				temp <= 4'b0100;
				flag = 0;
				end
				6'b100101://or
				begin
				temp <= 4'b0101;
				flag = 0;
				end
				6'b100010://sub
				begin
				temp <= 4'b0001;
				flag = 0;
				end
				6'b100111://nor
				begin
				temp <= 4'b1001;
				flag = 0;
				end
				6'b000000://sll
				begin
				temp <= 4'b0010;
				flag = 1;
				end
				6'b000100://sllv
				begin
				temp <= 4'b0010;
				flag = 0;
				end
				6'b000011://sra
				begin
				temp <= 4'b1011;
				flag = 1;
				end
				6'b000111://srav
				begin
				temp <= 4'b1011;
				flag = 0;
				end
				6'b000010://srl
				begin
				temp <= 4'b0011;
				flag = 1;
				end
				6'b000110://srlv
				begin
				temp <= 4'b0011;
				flag = 0;
				end
				6'b100110://xor
				begin
				temp <= 4'b0110;
				flag = 0;
				end
				6'b101010://slt
				begin
				temp <= 4'b1000;
				flag = 0;
				end
				6'b101011://sltu
				begin
				temp <= 4'b1101;
				flag = 0;
				end
	endcase
	end
assign flag_out = (~aluop)&flag|(aluop)&flagi;//for sa
assign aluctr  = ({ 4{(~aluop)} }&temp) | ({ 4{aluop} }&aluctri);
assign extop = (aluop&sign)|((~aluop)&sign);
endmodule

module control(input [5:0]opcode, input signbit, input [5:0]func, output regdst, output regwrite, output extop, output alusrc, output [3:0]aluctr, output b, output j, output flag, output memorytoreg, output memorywrite);
reg rdst,regwr,alusource,ext,aluop,branch,jump,memtoreg,memwr;
reg [3:0]rc;
assign regdst = rdst;
assign regwrite = regwr;
assign alusrc = alusource;
assign b = branch;
assign j = jump;
assign memorytoreg = memtoreg;
assign memorywrite = memwr;
always@(*)
begin
case(opcode)
	6'b000000://rtype
	begin
	rdst = 1;
	regwr = 1;
	alusource = 0;
	aluop = 0;
	jump = 0;
	branch = 0;
	memtoreg = 0;
	memwr = 0;
	end
	6'b001000://addi
	begin
	rdst = 0;
	regwr = 1;
	alusource = 1;
	ext = signbit;
	aluop = 1;
	jump = 0;
	branch = 0;
	memtoreg = 0;
	memwr = 0;
	rc = 4'b0000;
	end
	6'b001100://andi
	begin
	rdst = 0;
	regwr = 1;
	alusource = 1;
	ext = 0;
	aluop = 1;
	jump = 0;
	branch = 0;
	memtoreg = 0;
	memwr = 0;
	rc = 4'b0100;
	end
	6'b001101://ori
	begin
	rdst = 0;
	regwr = 1;
	alusource = 1;
	ext = 0;
	aluop = 1;
	jump = 0;
	branch = 0;
	memtoreg = 0;
	memwr = 0;
	rc = 4'b0101;
	end
	6'b001110://xori
	begin
	rdst = 0;
	regwr = 1;
	alusource = 1;
	ext = 0;
	aluop = 1;
	jump = 0;
	branch = 0;
	memtoreg = 0;
	memwr = 0;
	rc = 4'b0110;
	end
	6'b001010://slti
	begin
	rdst = 0;
	regwr = 1;
	alusource = 1;
	ext = signbit;
	aluop = 1;
	jump = 0;
	branch = 0;
	memtoreg = 0;
	memwr = 0;
	rc = 4'b1000;
	end
	6'b001011://sltiu
	begin
	rdst = 0;
	regwr = 1;
	alusource = 1;
	ext = signbit;
	aluop = 1;
	jump = 0;
	branch = 0;
	memtoreg = 0;
	memwr = 0;
	rc = 4'b1101;
	end
	6'b000100://beq
	begin
	rdst = 0;//don't care
	regwr = 0;
	alusource = 0;
	ext = signbit;//don't care
	aluop = 1;
	jump = 0;
	branch = 1;
	memtoreg = 0;
	memwr = 0;
	rc = 4'b1110;
	end
	6'b000111://bgtz
	begin
	rdst = 0;//don't care
	regwr = 0;
	alusource = 0;
	ext = signbit;//don't care
	aluop = 1;
	jump = 0;
	branch = 1;
	memtoreg = 0;
	memwr = 0;
	rc = 4'b1111;
	end
	6'b000110://blez
	begin
	rdst = 0;//don't care
	regwr = 0;
	alusource = 0;
	ext = signbit;//don't care
	aluop = 1;
	jump = 0;
	branch = 1;
	memtoreg = 0;
	memwr = 0;
	rc = 4'b1100;
	end
	6'b000101://bne
	begin
	rdst = 0;//don't care
	regwr = 0;
	alusource = 0;
	ext = signbit;//don't care
	aluop = 1;
	jump = 0;
	branch = 1;
	memtoreg = 0;
	memwr = 0;
	rc = 4'b1010;
	end
	6'b000010://j
	begin
	rdst = 0;//don't care
	regwr = 0;
	alusource = 0;
	ext = signbit;//don't care
	aluop = 1;
	jump = 1;
	branch = 0;
	memtoreg = 0;//don't care
	memwr = 0;
	rc = 4'b0000;//don't care
	end
	6'b000011://jal
	begin
	rdst = 0;//don't care
	regwr = 0;
	alusource = 0;
	ext = signbit;//don't care
	aluop = 1;
	jump = 1;
	branch = 0;
	memtoreg = 0;//don't care
	memwr = 0;
	rc = 4'b0111;//don't care
	end
	6'b100000://lb
	begin
	rdst = 0;
	regwr = 1;
	alusource = 1;
	ext = signbit;
	aluop = 1;
	jump = 0;
	branch = 0;
	memtoreg = 1;
	memwr = 0;
	rc = 4'b0000;
	end
	6'b101000://sb
	begin
	rdst = 0;//don't care
	regwr = 0;
	alusource = 1;
	ext = signbit;
	aluop = 1;
	jump = 0;
	branch = 0;
	memtoreg = 1;//don't care
	memwr = 1;
	rc = 4'b0000;
	end
endcase
end
loc_control l1(1'b0,rc,ext,func,aluop,aluctr[3:0],flag,extop);
endmodule

module ALU(input [3:0]c, input [31:0]x1, input [31:0]x2, output [31:0]y, output c_out);
reg [32:0] result;
assign y = result[31:0];
assign c_out = result[32];
always@(*)
begin
		case(c)
		4'b0000:
			result = x1+x2;
		4'b0001:
			result = x1-x2;
		4'b0010:
			result = x2<<x1;
		4'b0011:
			result = x2>>x1;
		4'b0100:
			result = x1&x2;
		4'b0101:
			result = x1|x2;
		4'b0110:
			result = x1^x2;
		4'b0111:
			result = 32'b00000000000000000000000000011111;//extra
		4'b1000:
			result = ($signed(x1))<($signed(x2))?32'b00000000000000000000000000000001:32'b00000000000000000000000000000000;
		4'b1001:
			result = ~(x1|x2);
		4'b1010:
			result = x1==x2?32'b00000000000000000000000000000001:32'b00000000000000000000000000000000;
		4'b1011:
			result = x2>>>x1;
		4'b1100:
			result = x1>0?32'b00000000000000000000000000000001:32'b00000000000000000000000000000000;
		4'b1101:
			result = x1<x2?32'b00000000000000000000000000000001:32'b00000000000000000000000000000000;
		4'b1110:
			result = x1==x2?32'b00000000000000000000000000000000:32'b00000000000000000000000000000001;
		4'b1111:
			result = x1>0?32'b00000000000000000000000000000000:32'b00000000000000000000000000000001;
		endcase
end
endmodule

module fetch(input clock, input branch, input zero, input jump, input [31:0]inp_instr, output [31:0]instruction, output [31:0]jal_pc);
reg [29:0] pc;
wire [29:0] updpc,brpc,broutpc,temp,nextpc,jpc;
wire sign;	
//Make Instruction Memory
reg [7:0] InstrMem [1023:0];
//Initialize pc and Instruction Memory
initial begin
pc <= 0;
//Load your instructions here
end
//pc getting updated
always@(negedge clock)
begin
	pc <= nextpc;
end
//Output assignment
assign instruction = {{InstrMem[{{pc},{2'b11}}]},{InstrMem[{{pc},{2'b10}}]},{InstrMem[{{pc},{2'b01}}]},{InstrMem[{{pc},{2'b00}}]}};//little endian
//Update pc
assign updpc = pc+1;
//Make branch pc
assign sign = instruction[15]; 
assign brpc = updpc + {{14{(sign)}},{inp_instr[15:0]}};
//Branch check
assign broutpc = (({29{(~(branch&zero))}}&updpc) | ({29{(branch&zero)}}&brpc));
//Make jump pc 
assign jpc = {{pc[29:26]},{inp_instr[25:0]}};
//Jump check
assign nextpc = (({30{(~jump)}}&broutpc) | ({30{jump}}&jpc));
//jal_pc
assign temp = pc+(30'b000000000000000000000000000010);
assign jal_pc = {{temp},{2'b00}};
endmodule

module decode_and_execute(input clock, input [31:0]x, input [31:0]jal_pc, output [31:0]y, output wire jump, output wire branch, output wire zero, output  wire [31:0]busw, output  wire [31:0]busa, output  wire [31:0]busb);
wire [3:0]aluctr;
assign y = x[31:0];
wire extop,alusrc,temp,flag,memtoreg,regwrite,memwr,regdst;
wire [31:0]alubus;
//Control Logic
control c1(x[31:26],x[15],x[5:0],regdst,regwrite,extop,alusrc,aluctr[3:0],branch,jump,flag,memtoreg,memwr);
//Making and Initializing Registers, Data Memory
reg [31:0] Registers [31:0];
reg [7:0] DataMem [1023:0];
integer i;
initial begin
	for(i=0; i<32; i=i+1)
		Registers[i] = 0;
	for(i=0; i<1024; i=i+1)
		DataMem[i] = 0;
	//Load Data Memory here
end

always@(negedge clock)
begin
	if(regwrite)
		Registers[(({5{(~regdst)}}&x[20:16]) | ({5{regdst}}&(x[15:11])))] <= busw;
	if(memwr)
		DataMem[alubus] <= busb[7:0];//SB:storing lowest 8 bits of busb
	case(aluctr)
	4'b0111:
		Registers[busw] <= jal_pc;//jal_pc Storage in register 31
	endcase	
end
//Assign busw
assign busw = (alubus & {32{(~memtoreg)}}) | ({{24{DataMem[alubus][7]}},{DataMem[alubus]}} & {32{memtoreg}});//LB:loading 0-extended value of Data Memory Register
//Assign busa, busb
assign busa = (flag&({27'b000000000000000000000000000,x[10:6]})) | ((~flag)&(Registers[(x[25:21])]));
assign busb = Registers[(x[20:16])];
//ALU
ALU a2(aluctr[3:0],busa,({ 32{(~alusrc)} }&busb) | ({ 32{alusrc} }&{ {16{extop}},x[15:0] }),alubus,temp);
assign zero = (~alubus[0]);//If ALU output is 0, then zero bit = 1
endmodule

module Main_Processor(input clock, output wire [31:0]busa, output wire [31:0]busb, output wire [31:0]busw, output wire [31:0]x);
wire [31:0]jal_pc,instruction;
reg branch1,zero1,jump1;
wire [31:0]recent_instr;
reg [31:0]inp_instr;
initial begin
	inp_instr <= 32'b00000000000000000000000000000000;
	branch1 <= 0;
	jump1 <= 0;
	zero1 <= 0;
end
fetch f1(clock,branch1,zero1,jump1,recent_instr,instruction,jal_pc);
assign x = instruction[31:0];
always@(negedge clock)
begin
	inp_instr <= instruction[31:0];
end
decode_and_execute e1(clock,inp_instr,jal_pc,recent_instr,jump,branch,zero,busw,busa,busb); 
always@(*)
begin
branch1 <= branch;
zero1 <= zero;
jump1 <= jump;
end
endmodule

