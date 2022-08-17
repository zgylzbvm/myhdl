module four_port_encoder(
    input [3:0] wl,
    input clk,
    input rst,
    output [3:0] wl_o,
    output done);
    
//reg [3:0] wl_reg;
reg done_reg;
reg [3:0] wl_tag;

always@(posedge clk or negedge rst)
    if (!rst_n) begin
    //  wl_reg<=4'b0000;
        wl_tag<=4'b1111;
        done_reg<=1'b0;
    end
    else if (wl[0]&wl_tag_wire[0]) begin
        wl_oreg<=4'b0001;
        wl_tag[3:0]<={wl_tag[3:1],1'b0};
    end
        //    wl_reg<=wl;
    else if (wl[1]&wl_tag_wire[1]) begin
        wl_oreg<=4'b0010;
        wl_tag[3:0]<={wl_tag[3:2],1'b0,wl_tag[0]};
    end  //  wl_reg<=wl;
    else if (wl[2]&wl_tag_wire[2]) begin
        wl_oreg<=4'b0100;
        wl_tag[3:0]<={wl_tag[3],1'b0,wl_tag[1:0]};
    end   // wl_reg<=wl;
    else if (wl[3]&wl_tag_wire[3]) begin
        wl_oreg<=4'b1000;
        wl_tag[3:0]<={1'b0,wl_tag[2:0]}
    end
    else begin
        done_reg<=1'b1;
        wl_oreg<=4'b0000;
        wl_tag<=4'b0000;
    end
       // wl_reg<=wl;
end
assign wl_o=wl_oreg;
assign done=done_reg;
assign wl_tag_wire=wl_tag;
endmodule
