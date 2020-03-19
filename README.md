# MIPS32-2-stage-pipelined-processor
A 2 stage pipelined processor with harvard architecture based on MIPS32 


Overall diagram of 2-staged pipelined MIPS processor



Fetch Unit

Decode and Execute Unit

Main Memory design
I have used Harvard architecture with different Data and Instruction Memory. Also I will be using 32 32-bit Registers. If size of Main Memory exceeds some particular limit, it will automatically use BRAM on FPGA. Data Memory and Registers are synchronous based Memory. I have used little-endian style.

Instructions Supported
All specified instructions are supported by my processor.




					







Instructions like LW,SW are not supported. MIPS standard instructions which are not mentioned in above list are not supported.

Processor Clock Frequency
I have set a Time period of 10ns for my clock. Each instruction gets fetched, decoded and executed completely within this time period. So my clock frequency is set to be 100MHz.

Pros and Cons
Pros:
I have accomplished all the specified requirements. I have used separate Instruction and Data Memory. There are a variety of instructions working on my processor.
Cons:
I haven’t found a way to automatically load instructions in instruction memory. I have to manually load them. Also I have to load machine code.


