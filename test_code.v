
module mul_matr #(
    parameter BITS =28
) (
               input clk, 
               input [1:0] mat_sel, 
	input [4:0]adr,
               //input[10:0] in_or_w1,
               input signed [20:0] w2, 
               output reg [2:0] decision 
               );


	reg signed [10:0] mem1 [BITS:0][BITS:0]; //input matrix
	reg signed [10:0] mem2 [BITS:0][BITS:0]; //weight matrix/hiddenlayer
	reg signed [20:0] mem3 [BITS:0][BITS:0]; //product matrix/hidden layer

	reg signed [20:0] mem4 [BITS:0][BITS:0]; //output matrix of hidden layer
	reg signed [20:0] mem5 [BITS:0][BITS:0]; //weight matrix/outputlayer
	reg signed [40:0] mem6 [BITS:0][BITS:0]; // product matrix/output layer

integer i;
integer j;
integer k;

integer p;
integer q;

integer r;
integer s;

integer a,b,c;

integer e,f;
//integer u,v, ready;
reg [2:0] index;

reg signed [40:0] temp;
reg [2:0] temp1;

reg [2:0] new;

always@(posedge clk)
begin

//input matrix
//mem1[0][0]=-4;
//mem1[0][1]= 15;
//mem1[1][0]=2;
//mem1[1][1]= 4;

if(mat_sel==2'b00)
begin
	mem1[adr]=w2;	
	
end
	
	
 if(mat_sel==2'b01)
		
begin
	
	mem2[adr]=w2;	
	
end
	
	
	
if(mat_sel==2'b10)
		
begin
	mem5[adr]=w2;	
	
end
	
	

// weight matrix hidden layer
//mem2[0][0]=20;
//mem2[0][1]= 15;
//mem2[1][0]=2;
//mem2[1][1]= 3;



// weight matrix output layer


//mem5[0][0]=100;
//mem5[0][1]= -25;
//mem5[1][0]=25;
//mem5[1][1]= 3;




//hidden layer calculations



//matrix initilization
	for (p=0;p<=BITS-1;p=p+1)begin
  
		for(q=0;q<=BITS-1;q=q+1)begin
   
	mem3[p][q]=0;
	mem6[p][q]=0;

end

  end



//matrix multiplication

	for (k=0;k<=BITS-1;k=k+1) begin

		for (i=0; i<=BITS-1;i=i+1)begin
 
			for (j=0;j<=BITS-1;j=j+1) begin
    mem3[k][i]=mem3[k][i]+(mem1[k][j]*mem2[j][i]);

    end


end

end


//out1=mem3[x][y];


//relu

	for(r=0;r<=BITS-1;r=r+1)begin

		for (s=0;s<=BITS-1;s=s+1) begin
   if(mem3[r][s]<=0)
	  mem4[r][s]=0;
	else if(mem3[r][s]>=0)
	   mem4[r][s]=mem3[r][s];
   

  end

end




//out2=mem4[x][y];



// output layer calculations




//matrix multiplication


	for (a=0;a<=BITS-1;a=a+1) begin

		for (b=0; b<=BITS-1;b=b+1)begin
 
			for (c=0;c<=BITS-1;c=c+1) begin
    mem6[a][b]=mem6[a][b]+(mem4[a][c]*mem5[c][b]);

    end


end

end



//out3=mem6[x][y];



// decision using comparison












temp=mem6[0][0];
index=0;
	for (e=0;e<=BITS-1;e=e+1) begin
 
		for(f=0;f<=BITS-1;f=f+1) begin
    index=index+1;
   if (temp<=mem6[e][f]) begin
	
	  //temp=mem6[e][f];
	  temp1=index;
	end
  else if(temp>=mem6[e][f])  begin
       
       temp=temp;
  end
	
	
end


end

//decision=temp1;
//out4=temp;

new=temp;
decision=temp1;



end




endmodule
