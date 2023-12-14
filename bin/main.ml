open Minipng

(* The cat that protects the code from bugs

    |\__/,|   (`\
  _.|o o  |_   ) )
-(((---(((--------
*)

let display_header header =
    Printf.printf "Width: %d\n" header.width;
    Printf.printf "Height: %d\n" header.height;
    Printf.printf "Pixel Type: %d " header.pixel_type;
    match header.pixel_type with
        0 -> print_endline "(black-and-white)"
        | _ -> print_endline "(other types not implemented)"

let () =
    let filename = Sys.argv.(1) in
    let blocks = parse_file filename in
    List.iter (function
        | Header header -> display_header header
        | Comment comment -> Printf.printf "Comments:\n\"%s\"\n" comment
        | Data _ -> () (* Data handling not implemented yet *)
    ) blocks