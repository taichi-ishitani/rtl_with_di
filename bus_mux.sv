module bus_mux (
  input var         i_clk,
  input var         i_rst_n,
  interface.arbiter arbiter,
  bus_if.slave      slave_if[2],
  bus_if.master     master_if
);
  logic [1:0] grant;

  always_comb begin
    arbiter.request[0]  = slave_if[0].valid && (grant == '0);
    arbiter.request[1]  = slave_if[1].valid && (grant == '0);
  end

  always_ff @(posedge i_clk, negedge i_rst_n) begin
    if (!i_rst_n) begin
      grant <= '0;
    end
    else if (master_if.ack()) begin
      grant <= '0;
    end
    else if (grant == '0) begin
      grant <= arbiter.grant;
    end
  end

  always_comb begin
    if (grant[0]) begin
      master_if.valid = slave_if[0].valid;
      master_if.data  = slave_if[0].data;
    end
    else if (grant[1]) begin
      master_if.valid = slave_if[1].valid;
      master_if.data  = slave_if[1].data;
    end
    else begin
      master_if.valid = '0;
      master_if.data  = '0;
    end
  end

  always_comb begin
    slave_if[0].ready = grant[0] && master_if.ready;
    slave_if[1].ready = grant[1] && master_if.ready;
  end
endmodule
