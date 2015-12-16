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

  integer i=0,j=0,k=0,count=0,errors=0; 
  reg [7:0]inX,inY;
  reg [7:0]expectOut,actualOut;

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
      $display("Storing initial data to the RAM");
      $display("================================");
      @(negedge Clock) programEn=1;AddrSel=5'b00000;Input=8'b10000000;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b00001;Input=8'b00111110;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b00010;Input=8'b10000000;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b00011;Input=8'b00111111;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b00100;Input=8'b00011110;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b00101;Input=8'b01111111;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b00110;Input=8'b10110000;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b00111;Input=8'b11001100;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b01000;Input=8'b00011111;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b01001;Input=8'b01111110;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b01010;Input=8'b00111111;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b01011;Input=8'b11000100;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b01100;Input=8'b00011110;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b01101;Input=8'b01111111;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b01110;Input=8'b00111110;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b01111;Input=8'b11000100;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b10000;Input=8'b00011110;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b10001;Input=8'b11111111;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b11110;Input=8'b00000000;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b",$time,Input,AddrIn);
      @(negedge Clock) AddrSel=5'b11111;Input=8'b00000000;Addrload=1;PRload=1;
      @(negedge Clock) $display("At time %0dps:\tInput=%b\tAddrIn=%b\n",$time,Input,AddrIn);
      @(negedge Clock) programEn=0;
    end
  endtask 
   
  task expectResult;
    input   [7:0]inX;
    input   [7:0]inY;
   begin
     while(inX!=inY)
      begin
        if(inX > inY)
          inX= inX - inY;
        else
          inY= inY - inX;
      end
    expectOut=inX;
   end
  endtask
   
  task actualResult; 
    input   [7:0]inX;
    input   [7:0]inY;
    begin
      Input=inX;//X value
      for(i=0;i<2;i=i+1)
       begin
        repeat (4) @(negedge Clock);
       end
      
      Input=inY;//Y value 
      for(j=0;j<2;j=j+1)
       begin
        repeat (4) @(negedge Clock);
       end
      
      while(outState!=4'b1111)
       begin
        repeat (4) @(negedge Clock);      
       end
       
       actualOut=Output;
   end
  endtask
    
  task verify_output;
    input [7:0] simulated_value;
    input [7:0] expected_value;
    begin
      if(simulated_value[7:0] != expected_value[7:0])
        begin
          errors=errors+1;
          $display("at Simulation time : %0dns,Simulated Output = %0d, Expected Output =%0d,error count =%0d\n",
                      $time,simulated_value,expected_value,errors);
        end
    end
  endtask  
    
  task Test_Summary;
   input [8:0]tested;
   input [8:0]errors;
   begin 
    $display("--------------------\nOVERALL TEST SUMMARY\n--------------------\nTESTED: %0d\nPASSED: %0d\nFAILED: %0d\nSIMULATED TIME: %0dns"
              ,tested,(tested-errors),errors,$time); 
   end
  endtask  
    
  initial 
    begin
      errors=0;count=0;Enter=1;
      
      plugInAssemblyCode();
      
      for(k=0;k<100;k=k+1)
       begin
        Reset=1;
        @(negedge Clock);
        inX={$random}%100;inY={$random}%100;
      
        actualResult(inX,inY); 
        expectResult(inX,inY);
        
        verify_output(actualOut,expectOut);
        
        Reset=0;
        @(negedge Clock);
        
        count=count+1;
       end
      Test_Summary(count,errors);
     $finish;
    end
    
    IT IT_test(Enter,programEn,Addrload,PRload,Input,AddrSel,Clock,Reset,Halt,Output,RAMout,AddrIn,Din,outState); 
    
  endmodule  