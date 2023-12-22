module testtest(
  input   pclk,
  input   button,
  output reg  [7:0] leg
);
reg [31:0] press_count, release_count, press_catch, release_catch;
reg start_case; 
reg [1:0] click;

reg clk1, clk2, clk3, clk4, clk5, clk6, clk7, clk8, clk9,
    clk10, clk11, clk12, clk13, clk14, clk15, clk16, clk17, clk18, clk19,
    clk20, clk21, clk22, clk23, clk24, clk25;

always @(posedge pclk) clk1 <= ~clk1; 
always @(posedge clk1) clk2 <= ~clk2; 
always @(posedge clk2) clk3 <= ~clk3; 
always @(posedge clk3) clk4 <= ~clk4; 
always @(posedge clk4) clk5 <= ~clk5; 
always @(posedge clk5) clk6 <= ~clk6;  
always @(posedge clk6) clk7 <= ~clk7; 
always @(posedge clk7) clk8 <= ~clk8; 
always @(posedge clk8) clk9 <= ~clk9; 
always @(posedge clk9) clk10 <= ~clk10; 
always @(posedge clk10) clk11 <= ~clk11;
always @(posedge clk11) clk12 <= ~clk12;
always @(posedge clk12) clk13 <= ~clk13;
always @(posedge clk13) clk14 <= ~clk14;
always @(posedge clk14) clk15 <= ~clk15;
always @(posedge clk15) clk16 <= ~clk16;
always @(posedge clk16) clk17 <= ~clk17;
always @(posedge clk17) clk18 <= ~clk18;
always @(posedge clk18) clk19 <= ~clk19;
always @(posedge clk19) clk20 <= ~clk20;
always @(posedge clk20) clk21 <= ~clk21;
always @(posedge clk21) clk22 <= ~clk22;
always @(posedge clk22) clk23 <= ~clk23;
always @(posedge clk23) clk24 <= ~clk24;
always @(posedge clk24) clk25 <= ~clk25;


reg last_clk_in;
wire count_en;
always @(posedge pclk) begin //posedge detection
  last_clk_in <= clk25;
end
assign count_en = ~last_clk_in & clk25;


always @(posedge pclk) begin //count
  if (button == 1'b0) begin
    press_count <= press_count + 1'b1;
    release_count <= 32'h0000_0000;
  end else begin
    press_count <= 32'h0000_0000;
    release_count <= release_count + 1'b1;
  end
end

always @(posedge pclk) begin //click
  if(button == 1'b0 && release_catch != 32'h0000_0000) begin
    if(release_catch < 32'd25000000) begin
      click <= click + 1'b1;
    end else begin
      click <= 2'b01;
    end
  end else begin
    click <= click;
  end
end

always @(posedge pclk) begin //start case
	if (button == 1'b1 && press_count != 32'h0000_0000) begin
		start_case <= 1'b1;
	end else if (click == 2'b01) begin
		if (press_catch >= 32'd100000000 && press_catch < 32'd250000000) begin
			if (start_case == 1'b1) begin
				start_case <= 1'b0;
			end else begin
				start_case <= start_case;
			end
		end else if (press_catch >= 32'd250000000) begin
			if (start_case == 1'b1) begin
				start_case <= 1'b0;
			end else begin
				start_case <= start_case;
			end
		end else begin
			start_case <= start_case;
		end
	end else if (click == 2'b10) begin
		if (start_case == 1'b1) begin
			start_case <= 1'b0;
		end else begin
			start_case <= start_case;
		end
	end else begin
		if (start_case == 1'b1) begin
			start_case <= 1'b0;
		end else begin
			start_case <= start_case;
		end
	end
end

always @(posedge pclk) begin //press_catch
  if (button == 1'b1 && press_count != 32'h0000_0000) begin
    press_catch <= press_count;
    //start_case <= 1'b1;
  end else begin
    press_catch <= press_catch;
  end
end

always @(posedge pclk) begin //release_catch
  if (button == 1'b0) begin
    release_catch <= release_count;
  end else begin
    release_catch <= release_catch;
  end
end

always @(posedge pclk) begin //control_leg
  if (click == 2'b01) begin
    if (press_catch < 32'd100000000) begin
      leg <= 8'hff;
    end else if (press_catch >= 32'd100000000 && press_catch < 32'd250000000) begin
      if (start_case == 1'b1) begin
        leg <= 8'h01;
        //start_case <= 1'b0;
      end else begin
        if (leg == 8'h00) begin
          leg <= 8'h01;
        end else begin
          if (count_en == 1'b1) begin
            leg <= {leg[6:0], 1'b0};
          end else begin
            leg <= leg;
          end
        end
      end
    end else if (press_catch >= 32'd250000000) begin
      if (start_case == 1'b1) begin
        leg <= 8'h80;
        //start_case <= 1'b0;
      end else begin
        if (leg == 8'h00) begin
          leg <= 8'h80;
        end else begin
          if (count_en == 1'b1) begin
            leg <= {1'b0, leg[7:1]};
          end else begin
            leg <= leg;
          end
        end
      end
    end else begin
      leg <= leg;
    end
  end else if(click == 2'b10) begin
    if (start_case == 1'b1) begin
      leg <= 8'h81;
      //start_case <= 1'b0;
    end else begin
      if (leg == 8'h00) begin
        leg <= 8'h81;
      end else begin
        if (count_en == 1'b1) begin
          leg <= {1'b0, leg[7:5], leg[2:0], 1'b0};
        end else begin
          leg <= leg;
        end
      end
    end
  end else begin
    if (start_case == 1'b1) begin
      leg <= 8'h18;
      //start_case <= 1'b0;
    end else begin
      if (leg <= 8'h00) begin
        leg <= 8'h18;
      end else begin
        if (count_en == 1'b1) begin
          leg <= {leg[6:4], 1'b0, 1'b0, leg[3:1]};
        end else begin
          leg <= leg;
        end
      end
    end
  end
end

endmodule
