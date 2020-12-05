interface fixed_prioriy_arbiter;
  logic [1:0] request;
  logic [1:0] grant;

  always_comb begin
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

  modport arbiter (
    output  request,
    input   grant
  );
endinterface
