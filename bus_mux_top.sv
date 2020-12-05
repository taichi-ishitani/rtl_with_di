module bus_mux_top (
  input var     i_clk,
  input var     i_rst_n,
  bus_if.slave  slave_if[4],
  bus_if.master master_if[2]
);
  fixed_prioriy_arbiter u_fixed_prioriy_arbiter();
  roundrobin_arbiter    u_roundrobin_arbiter(i_clk, i_rst_n);

  bus_mux u_fixed_prioriy_mux (
    .i_clk      (i_clk                    ),
    .i_rst_n    (i_rst_n                  ),
    .arbiter    (u_fixed_prioriy_arbiter  ),
    .slave_if   (slave_if[0:1]            ),
    .master_if  (master_if[0]             )
  );

  bus_mux u_roundrobin_mux (
    .i_clk      (i_clk                ),
    .i_rst_n    (i_rst_n              ),
    .arbiter    (u_roundrobin_arbiter ),
    .slave_if   (slave_if[2:3]        ),
    .master_if  (master_if[1]         )
  );
endmodule
