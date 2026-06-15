.main clear
vlog uart_txd_fifo_tb.v +acc
vsim uart_txd_fifo_tb
add wave /uart_txd_fifo_tb/txd_fifo/fifo/*
add wave /uart_txd_fifo_tb/txd_fifo/tx/*
run -all
