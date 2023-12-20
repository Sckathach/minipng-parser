open Lib.Minipng
(* The cat that protects the code from bugs

    |\__/,|   (`\
  _.|o o  |_   ) )
-(((---(((--------
*)


(* let () = *)
(*    let filename = Sys.argv.(1) in *)
(*    let blocks = parse_file filename in *)
(*    let minipng = blocks_to_minipng blocks in *)
(*    Printf.printf "%s" (display_header minipng); *)
(*    Printf.printf "%s" (display_comment minipng); *)
(*    Printf.printf "%s" (display_data minipng); *)

open Printf
let reset_ppf = Spectrum.prepare_ppf Format.std_formatter;;
let red = Spectrum.Simple.sprintf "@{<bg:#f00>%s@}" " ";;
let blue = Spectrum.Simple.sprintf "@{<bg:#00f>%s@}" " ";;
let white = Spectrum.Simple.sprintf "@{<bg:#fff>%s@}" " ";;
let create_color r g b  = sprintf "@{<rgb(%d %d %d)>%%s@}" r g b;;
(* Format.printf (sprintf "%s" (create_color 50 50 50)) " " ;; *)
(* Format.printf (sprintf "%s" (create_color 100 50 50)) " ";; *)
(* Format.printf (sprintf "%s" (create_color 10 10 10)) " ";; *)
(* Format.printf (sprintf "%s" (create_color 210 120 0)) " ";; *)
(*  *)
Format.printf "@{<bg:rgb(%d %d %d)>%s@}" 100 100 100 " ";;
Format.printf "@{<bg:rgb(%d %d %d)>%s@}" 0 0 0 " ";;
Format.printf "@{<bg:rgb(%d %d %d)>%s@}" 200 200 200 " ";;
Format.printf "@{<bg:rgb(%d %d %d)>%s@}" 150 150 150 " ";;
reset_ppf ();;
