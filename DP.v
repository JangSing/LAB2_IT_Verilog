module DP(
   input  Reset,Clock,
   input  [7:0]Input,
   input  IRload,JMPmux,PCload,Meminst,MemWr,Aload,Sub,Halt,programEn,Addrload,PRload,
   input  [4:0]AddrSel,
   input  [1:0]Asel,
   output reg Aeq0,
   output Apos,
   output [7:0]Output,
   output [2:0]IR
   );
   
   reg  [7:0]Din;
   reg  [4:0]AddrIn;
   wire [7:0]Aout,AselOut,SubOut,in3;
   wire [4:0]MeminstOut,JMPout,PCout,increOut;
   wire [7:0]RAMout,IRout;
   
   wire [7:0]InputTemp;
   wire [4:0]AddrSelTemp;
   
   RAM32x8            RAM(MemWr,Clock,AddrIn,Din,RAMout);
   nBitsRegister #(8) Areg(Aload,Reset,Clock,AselOut,Aout);
   Multiplexer4to1    AselMUX(SubOut,Input,RAMout,in3,Asel,AselOut);
   SubOrAdd           SubAdd(Aout,RAMout,Sub,SubOut);
   Multiplexer2to1    MeminstMUX(PCout,IRout[4:0],Meminst,MeminstOut);
   nBitsRegister #(5) PCreg(PCload,Reset,Clock,JMPout,PCout); 
   Multiplexer2to1    jmpMUX(increOut,IRout[4:0],JMPmux,JMPout);
   nBitsRegister #(8) IRreg(IRload,Reset,Clock,RAMout,IRout); 
   Increment5bit      _5bitIncrement(PCout,increOut);
   
   nBitsRegister #(8) AddrReg(Addrload,Reset,Clock,Input,InputTemp); 
   nBitsRegister #(5) ProgramReg(PRload,Reset,Clock,AddrSel,AddrSelTemp); 
   
   always@(programEn)
    begin
      if(programEn)
        Din=InputTemp;
      else
        Din=Aout;
    end
   
   always@(programEn)
    begin
      if(programEn)
        AddrIn=AddrSelTemp;
      else
        AddrIn=MeminstOut;
    end
    
    
   always@(Aout)
    begin
      if(!Aout)
        Aeq0=1;
      else
        Aeq0=0;
    end
    
   assign Apos=Aout[7:7];
   assign in3=0;
   assign Output=Aout;
   assign IR=IRout[7:5];
 
 
 
 
 endmodule  