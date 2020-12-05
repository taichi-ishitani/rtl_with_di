interface roundrobin_arbiter (
  input var i_clk,
  input var i_rst_n
);
  logic [1:0] request;
  logic [1:0] grant;
  logic [1:0] previous_grant;

  always_ff @(posedge i_clk, negedge i_rst_n) begin
    if (!i_rst_n) begin
      previous_grant  <= 2'b01;
    end
    else if (request != '0) begin
      previous_grant  <= grant;
    end
  end

  always_comb begin
    if (previous_grant[0]) begin
      if (request[1]) begin
        grant = 2'b10;
      end
      else if (request[0]) begin
        grant = 2'b01;
      end
      else begin
        grant = 2'b00;
      end
    end
    else begin
      if (request[0]) begin
        grant = 2'b01;
      end
      else if (request[1]) begin
        grant = 2'b10;
      end
      else begin
        grant = 2'b00;
      end
    end
  end

  modport arbiter (
    output  request,
    input   grant
  );
endinterface
