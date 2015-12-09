module IT(
  input   Enter,
  input   [7:0]Input,
  input   Clock,Reset,
  output  Halt,
  output  [7:0]Output
);

wire IRload,JMPmux,PCload,Meminst,MemWr,Aload,Sub,Aeq0,Apos;
wire [1:0]Asel;
wire [2:0]IR;

LAB2_CU   cu1(IR,Aeq0,Apos,Enter,Clock,Reset,IRload,JMPmux,PCload,Meminst,MemWr,Aload,Sub,Halt,Asel);
DP        dp1(Reset,Clock,Input,IRload,JMPmux,PCload,Meminst,MemWr,Aload,Sub,Halt,Asel,Aeq0,Apos,Output,IR);

endmodule 
