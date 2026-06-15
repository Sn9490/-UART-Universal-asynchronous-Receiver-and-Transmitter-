vlog uart_rec_top_tb.v +acc
vsim uart_rec_top_tb
add wave /uart_rec_top_tb/urt/r1/*
add wave /uart_rec_top_tb/urt/tf/*
run -all
