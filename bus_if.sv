interface bus_if #(int BUS_WIDTH = 1);
  logic                 valid;
  logic                 ready;
  logic [BUS_WIDTH-1:0] data;

  function automatic logic ack();
    return valid && ready;
  endfunction

  modport master (
    output  valid,
    input   ready,
    output  data,
    import  ack
  );

  modport slave (
    input   valid,
    output  ready,
    input   data,
    import  ack
  );
endinterface
