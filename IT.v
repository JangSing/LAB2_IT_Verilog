module IT(
  input   Enter,programEn,Addrload,PRload,
  input   [7:0]Input,
  input   [4:0]AddrSel,
  input   Clock,Reset,
  output  Halt,
  output  [7:0]Output,RAMout,
  output  [4:0]AddrIn,
  output  [7:0]Din,
  output  [3:0]outState
);

wire IRload,JMPmux,PCload,Meminst,MemWr,Aload,Sub,Aeq0,Apos;
wire [1:0]Asel;
wire [2:0]IR;

LAB2_CU   cu1(IR,Aeq0,Apos,Enter,Clock,Reset,IRload,JMPmux,PCload,Meminst,MemWr,Aload,Sub,Halt,Asel,outState);
DP        dp1(Reset,Clock,Input,IRload,JMPmux,PCload,Meminst,MemWr,Aload,Sub,Halt,programEn,Addrload,PRload,AddrSel,Asel,Aeq0,Apos,Output,RAMout,               IR,AddrIn,Din);

endmodule 
