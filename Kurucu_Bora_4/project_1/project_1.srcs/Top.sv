`timescale 1ns / 1ps


//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.12.2019 12:46:22
// Design Name: 
// Module Name: Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clkDivider(input clk_in,output logic clk_out);
logic [64:0] cnt;

initial begin
    cnt = 64'b0;
    clk_out = 0;
end

always@(posedge clk_in)
begin
   if(cnt == 64'd10000000)
     begin
        clk_out = ~clk_out;
        cnt = 64'd0;
     end
   else
     begin
        cnt  = cnt + 1'b1;
     end
end
endmodule




module converter(input logic clk, input logic [7:0][7:0] data_in,
     output logic[7:0] rowsOut1,
     output logic shcp1,output logic stcp1,output logic mr1,output logic oe1,output logic ds1 );
   

     logic [7:0][7:0] data;
     always_comb
     for(int k=0; k<8; k++)
     for(int j=0; j<8; j++)
     begin
         data[7-j][k]=data_in[k][j];
     end

     logic f;
     logic [23:0] dstotal;

     int i; logic [2:0] a = 0;

     assign dstotal =  {data[a][7:0],16'b0};
      logic [7:0] counter =0;

       always_ff@(posedge clk)
       counter <= counter+1;

       assign f = counter[7];

       always_ff@(negedge f)
       if(i==410)
       i<=1;
       else
       i <= i+1;

       always_ff@(negedge clk)
       if(i<28)
       begin
       shcp1<=f;
       stcp1<=~f;
       end
       else
       begin
       shcp1<=0;
       stcp1<=1;
       end


       always_ff@(posedge f)
           if(i>28 && i<409)
           oe1 <= 0;
           else
           oe1<= 1;

     always_ff@(negedge f)
     begin
     if(i<3)
     mr1<=0;
     else
     mr1<=1;
     if(i>2&&i<27)
     ds1 <= dstotal[i-3];
     else
     ds1 <=0;
     if(i==410) a <= a+1;
     end




     always_comb
     case(a)
     0: rowsOut1 = 1;
     1: rowsOut1 = 2;
     2: rowsOut1 = 4;
     3: rowsOut1 = 8;
     4: rowsOut1 = 16;
     5: rowsOut1 = 32;
     6: rowsOut1 = 64;
     7: rowsOut1 = 128;
     default: rowsOut1 = 0;
     endcase

endmodule



 module Top(input clk,input reset,input restart,input btn1,input btn2,input btn3,input btn4,input strt, output logic[7:0] rowsOut,
     output logic shcp,output logic stcp,output logic mr,output logic oe,output logic ds,input assigner,input insert,input [1:0] ledSel, input [1:0] digSel,input [3:0] values,output a, b, c, d, e, f, g, dp,
output [3:0] an,output logic [15:0] result );


logic [63:0] out;
logic [7:0][7:0] data;
logic [7:0][7:0] newdata;
logic [63:0] sevo;
logic [3:0] numbers [7:0][7:0];
logic ct;
logic gameStarted;
logic firstStarted;
logic [63:0] ctr;
logic s1Prev;
logic inc;
logic [63:0] barage;
//sevseger(clk,assigner, insert,ledSel,digSel,values,a, b, c, d, e, f, g, dp,an,result,sevo,gameStarted);


logic [3:0] v0;
logic [3:0] v1;
logic [3:0] v2;
logic [3:0] v3;
logic prev;

logic [1:0] counter;

logic [15:0] first;
logic [15:0] second;
logic [15:0] third;
logic [15:0] fourth;
logic [15:0]  v0T;
logic [15:0] v1T;
logic [15:0] v2T;
logic [15:0] fourthT;
logic [15:0] ctrS;
logic used;
logic used2;
logic used3;
logic used4;
logic [8:0] index2;
logic clkDiv;
logic predata;
logic ener;
logic [2:0] left;
logic [2:0] right;
logic [2:0] up;
logic [2:0] down;

logic inFirst;




initial begin
ener = 1'b1;
predata = 0;
clkDiv = 0;
barage = 64'b01;
used = 0;
used2 = 0;
used3 = 0;
used4 = 0;
firstStarted = 0;
inFirst = 0;
counter = 2'b00;
first = 16'b0;
second = 16'b0;
third = 16'b0;
fourth = 16'b0;
result = 16'b0;
prev = 0;
end

always@(posedge clk)
begin

if(insert == 0)
prev <= 0;


if( digSel == 2'b00 && assigner == 1'b1 && gameStarted == 0)
v0 <= values;
else if( digSel == 2'b01 && assigner == 1'b1 && gameStarted == 0)
v1 <= values;
else if( digSel == 2'b10 && assigner == 1'b1 && gameStarted == 0)
v2 <= values;
else if (digSel == 2'b11 && assigner == 1'b1 &&  gameStarted == 0)
v3 <= values;
else if(gameStarted == 1)
begin

if(restart || strt)
begin
ctrS <= 0;
used <= 0;
used2 <= 0;
used3 <= 0;
used4 <= 0;
end

if(btn1 == 0)
used <= 0;

if(btn1 == 1 && used == 0)
begin
used <= 1;
ctrS <= ctrS + 1;
end

if(btn2 == 0)
used2 <= 0;

if(btn2 == 1 && used2 == 0)
begin
used2 <= 1;
ctrS <= ctrS + 1;
end

if(btn3 == 0)
used3 <= 0;

if(btn3 == 1 && used3 == 0)
begin
used3 <= 1;
ctrS <= ctrS + 1;
end

if(btn4 == 0)
used4 <= 0; 

if(btn4 == 1 && used4 == 0)
begin
used4 <= 1;
ctrS <= ctrS + 1;
end

/*if( btn1 == 1 && used == 0)
ctrS <= ctrS + 1;*/

v0 <= ctrS[3:0];
v1 <= ctrS[7:4];
v2 <= ctrS[11:8];
v3 <= ctrS[15:12];
end



if(insert == 1 && first == 0 && prev == 0)
begin
first <= {v3,v2,v1,v0};
prev <= 1;
end
else if(insert == 1 && second == 0 && first > 0 && prev == 0)
begin
second <= {v3,v2,v1,v0};
prev <= 1;
end
else if(insert == 1 && third == 0 && second > 0 && prev == 0)
begin
third <= {v3,v2,v1,v0};
prev <= 1;
end
else if(insert == 1 && fourth == 0 && third > 0 && prev == 0)
begin
fourth <= { v3,v2,v1,v0};
prev <= 1;
end
else if(fourth != 0 && gameStarted == 0)
begin
sevo <= { fourth,third,second,first};
end


if(ledSel == 2'b00 && first > 0)
result <= first;
else if(ledSel == 2'b01 && second > 0)
result <= second;
else if(ledSel == 2'b10 && third > 0)
result <= third;
else if(ledSel == 2'b11 && fourth > 0)
begin
result <= fourth;
end


if(reset || firstStarted)
begin
     inFirst <= 0;
      counter <= 2'b00;
      first <= 16'b0;
      second <= 16'b0;
      third <= 16'b0;
      fourth <= 16'b0;
      result <= 16'b0;
      if(reset)
      sevo <= 0;
      prev <= 0;
      v0 <= 0;
      v1 <= 0;
      v2 <= 0;
      v3 <= 0;
   

end


end


clkDivider div(clk,clkDiv);

always@(posedge clkDiv)
begin
if(data == 0 && gameStarted == 1)
ener <= ~ener;
else
ener <= 0;
end


SevSeg_4digit seg(clk,ener,v0,v1,v2,v3,a, b, c, d, e, f, g, dp,an);



initial begin
inc = 0;
gameStarted = 0;
s1Prev = 0;
 ct = 1;
 for(int k=0; k<8; k++)
   for(int j=0; j<8; j++)
     begin
         data[k][j] = 3'b000;
         
     end

end

typedef enum logic [3:0] {S0, S1, S2,S3,S4,S5,S6,S7} statetype;
statetype state, nextstate;  

always_ff @ (posedge clk)
if(strt || restart)
begin
state <= S0;
end
else
state <= nextstate;

 
always_comb
 case (state)
 S0:
  nextstate = S2;
 S1:
     nextstate = S2;
 S2:
       begin
      if(reset == 1)
      nextstate = S6;
      else if(restart == 1)
      nextstate = S7;
      else if(strt == 1)
      nextstate = S0;
      else if(btn1)
      nextstate = S1;
      else if(btn2)
       nextstate = S3;
       else if(btn3)
       nextstate = S4;
      else if(btn4)
       nextstate = S5;
      else
      nextstate = S2;
      end
      
 S3: begin 
      nextstate = S2;
 end
 S4:
    nextstate = S2;
 S5:
    nextstate = S2;
 S6:
    nextstate = S2;
 S7:
    nextstate = S0;
 default: nextstate = S2;
 endcase    
 
always @(posedge clk)
 begin
 case(state)
 S7:
    begin
     gameStarted = 0;
     firstStarted = 0;
    end
 S6: begin
      gameStarted = 0;
      firstStarted = 0;
      for(int k=0; k<8; k++)
         for(int j=0; j<8; j++)
           begin
               data[k][j] = 3'b000;
               newdata[k][j] = 3'b000;
           end
           

 
     end
 
 S0: begin 
    logic [8:0] index;
    index = 0;
    
    
    for(int k=0; k<8; k++)
   for(int j=0; j<8; j++)
     begin
         data[k][j] = sevo[index];
         newdata[k][j] = sevo[index];
         index = index + 1;
        
     end  
     
     
     
       for(int k=0; k<8; k++)
        for(int j=0; j<8; j++)
          begin
          
          
          if( j % 2 == 0)
             begin
          if(k % 2 == 0)
          numbers[k][j] = 3'b001;
          else
          numbers[k][j] = 3'b100;
          
            end
          else
            begin
          
          if(k % 2 == 0)
          numbers[k][j] = 3'b010;
                    
           else
          numbers[k][j] = 3'b011;
          
             end
          
          
          
          end
          
          
 
 for(int k=4; k<8; k++)
for(int j=0; j<4; j++)
begin
if( j % 2 == 0)
begin
if( k % 2 == 0)
numbers[k][j] = 3'b010;
else
numbers[k][j] = 3'b011;
end
else
begin
if( k % 2 == 0)
numbers[k][j] = 3'b001;
else
numbers[k][j] = 3'b100;

end
end
    end

 S1:  begin 
 if(gameStarted == 0)
  firstStarted = 1;
 gameStarted = 1;
 
 for(int k=0; k<8; k++)
   for(int j=0; j<8; j++)
   begin
    up = (( k + 1) + 8 ) % 8;
      down = (( k - 1) + 8 ) % 8;
      left = (( j - 1) + 8 ) % 8;
      right = (( j + 1) + 8 ) % 8;
   if(numbers[k][j] == 3'b001)
    begin
   
    
   if( ( data[k][left] && data[down][j] == 0  ) ||
                 ( data[up][j] && data[down][j] == 0 ) ||
                 ( data[up][j] == 0 && data[k][right] && data[down][j]) )
     newdata[k][j] = 1;
    else
    newdata[k][j] = 0;
    end
 
   end
   

end




 S2: begin 
      data = newdata;  
      s1Prev = 0;
      firstStarted = 0;
      
      
      
      
      

       
    
     end
     
     
     
    
 S3:begin
 gameStarted = 1;

    for(int k=0; k<8; k++)
         for(int j=0; j<8; j++)
         begin
         if(numbers[k][j] == 3'b010)
          begin
          up = (( k + 1) + 8 ) % 8;
          down = (( k - 1) + 8 ) % 8;
          left = (( j - 1) + 8 ) % 8;
          right = (( j + 1) + 8 ) % 8;
          
         if( ( data[k][left] && data[down][j] == 0  ) ||
              ( data[up][j] && data[down][j] == 0 ) ||
              ( data[up][j] == 0 && data[k][right] && data[down][j]) )
          newdata[k][j] = 1;
          else
          newdata[k][j] = 0;
          end


     
    end
    end
S4:
begin
gameStarted = 1;


    for(int k=0; k<8; k++)
         for(int j=0; j<8; j++)
         begin
         if(numbers[k][j] == 3'b011)
          begin
          up = (( k + 1) + 8 ) % 8;
          down = (( k - 1) + 8 ) % 8;
          left = (( j - 1) + 8 ) % 8;
          right = (( j + 1) + 8 ) % 8;
          
         if( ( data[k][left] && data[down][j] == 0  ) ||
              ( data[up][j] && data[down][j] == 0 ) ||
              ( data[up][j] == 0 && data[k][right] && data[down][j]) )
          newdata[k][j] = 1;
          
          else
          newdata[k][j] = 0;
          end
        
end


end
S5:
begin
gameStarted = 1;


    for(int k=0; k<8; k++)
         for(int j=0; j<8; j++)
         begin
         if(numbers[k][j] == 3'b100)
          begin
          up = (( k + 1) + 8 ) % 8;
          down = (( k - 1) + 8 ) % 8;
          left = (( j - 1) + 8 ) % 8;
          right = (( j + 1) + 8 ) % 8;
          
          if( ( data[k][left] && data[down][j] == 0  ) ||
              ( data[up][j] && data[down][j] == 0 ) ||
              ( data[up][j] == 0 && data[k][right] && data[down][j]) )
          newdata[k][j] = 1;
          
         else
         newdata[k][j] = 0;
          end
        end



end
 endcase
 end
 
converter con(clk,data,rowsOut,shcp, stcp, mr, oe, ds);


endmodule
