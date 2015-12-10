`timescale 1ps/1ps

module IT_tb();
  reg   Enter,programEn,Addrload,PRload;
  reg   [7:0]Input;
  reg   [4:0]AddrSel;
  reg   Clock,Reset;
  wire  Halt;
  wire  [7:0]Output,RAMout;
  wire  [4:0]AddrIn;
  wire  [7:0]Din;
  wire  [3:0]outState;


//always triggerring the clock
  initial
   begin
    Clock <= 0;
    forever #1 Clock=~Clock;
   end

//the Reset block 
  initial
   begin
    repeat (40) @(negedge Clock);
    Reset <= 0;
    @(posedge Clock);
    @(negedge Clock) Reset=1;
   end   
   
  task plugInAssemblyCode();
    begin
      @(negedge Clock) programEn=1;AddrSel=5'b00000;Input=8'b10000000;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b00001;Input=8'b00111110;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b00010;Input=8'b10000000;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b00011;Input=8'b00111111;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b00100;Input=8'b00011110;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b00101;Input=8'b01111111;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b00110;Input=8'b10110000;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b00111;Input=8'b11001100;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b01000;Input=8'b00011111;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b01001;Input=8'b01111110;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b01010;Input=8'b00111111;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b01011;Input=8'b11000100;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b01100;Input=8'b00011110;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b01101;Input=8'b01111111;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b01110;Input=8'b00111110;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b01111;Input=8'b11000100;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b10000;Input=8'b00011110;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b10001;Input=8'b11111111;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b11110;Input=8'b00000000;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b11111;Input=8'b00000000;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) programEn=0;
    end
  endtask 
   
  task expectResult();
   begin
   end
 endtask
   
   
  initial 
    begin
      plugInAssemblyCode();
      Input=8'b01101110;
      /*
      repeat (3) @(negedge Clock); //start + fetch +decode
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tRAMout=%b\tOutput=%b\toutState=%b\tAddrIn=%b\n",$time,Input,RAMout,Output,outState,AddrIn);   
      @(negedge Clock)Enter=1;
      repeat (3) @(negedge Clock); //start + fetch +decode
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tRAMout=%b\tOutput=%b\toutState=%b\tAddrIn=%b\n",$time,Input,RAMout,Output,outState,AddrIn);
      repeat (3) @(negedge Clock); //start + fetch +decode
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tRAMout=%b\tOutput=%b\toutState=%b\tAddrIn=%b\n",$time,Input,RAMout,Output,outState,AddrIn);
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tRAMout=%b\tOutput=%b\toutState=%b\tAddrIn=%b\n",$time,Input,RAMout,Output,outState,AddrIn);
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tRAMout=%b\tOutput=%b\toutState=%b\tAddrIn=%b\n",$time,Input,RAMout,Output,outState,AddrIn);
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tRAMout=%b\tOutput=%b\toutState=%b\tAddrIn=%b\n",$time,Input,RAMout,Output,outState,AddrIn);
      */
      repeat (3) @(negedge Clock); //start + fetch +decode
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tRAMout=%b\tOutput=%b\toutState=%b\tAddrIn=%b\n",$time,Input,RAMout,Output,outState,AddrIn);
    end
   
  IT IT_test(Enter,programEn,Addrload,PRload,Input,AddrSel,Clock,Reset,Halt,Output,RAMout,AddrIn,Din,outState); 
   
endmodule
