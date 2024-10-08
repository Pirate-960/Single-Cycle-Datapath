module mult4_to_2_5(out, i0, i1, i2, i3, s0);
  output [4:0] out;
  input [4:0] i0, i1, i2, i3;
  input [1:0] s0; // 2-bit selection input

  assign out = (s0 == 2'b00) ? i0 :
               (s0 == 2'b01) ? i1 :
               (s0 == 2'b10) ? i2 :
                               i3; // when s0 == 2'b11
endmodule