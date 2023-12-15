open Lib.Minipng
(* The cat that protects the code from bugs

    |\__/,|   (`\
  _.|o o  |_   ) )
-(((---(((--------
*)


let () =
    let filename = Sys.argv.(1) in
    let blocks = parse_file filename in
    let minipng = blocks_to_minipng blocks in
    Printf.printf "%s" (display_header minipng);
    Printf.printf "%s" (display_comment minipng);
    Printf.printf "%s" (display_data minipng);
