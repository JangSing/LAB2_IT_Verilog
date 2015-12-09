`timescale 1ps/1ps

module IT_tb();
  reg   Enter,programEn,Addrload,PRload;
  reg   [7:0]Input;
  reg   [4:0]AddrSel;
  reg   Clock,Reset;
  wire  Halt;
  wire  [7:0]Output;


//always triggerring the clock
  initial
   begin
    Clock <= 0;
    forever #1 Clock=~Clock;
   end

//the Reset block 
  initial
   begin
    Reset <= 0;
    @(posedge Clock);
    @(negedge Clock) Reset=1;
   end   
   
  initial 
    begin
      repeat (2) @(negedge Clock);programEn=1;
      $display("At time %0dps:\tInput=%b\tOutput=%b\tprogramEn=%b\n",$time,Input,Output,programEn);
      
      
      
    end
   
  IT IT_test(Enter,programEn,Addrload,PRload,Input,AddrSel,Clock,Reset,Halt,Output); 
   
endmodule
