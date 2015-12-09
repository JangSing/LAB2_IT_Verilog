`timescale 1ps/1ps

module IT_tb();
  reg   Enter;
  reg   [7:0]Input;
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
      repeat (10) @(negedge Clock);
      $display("At time %0dps:\tInput=%b\tOutput=%b\n",$time,Input,Output);
      
      
      
    end
   
  IT IT_test(Enter,Input,Clock,Reset,Halt,Output); 
   
endmodule
