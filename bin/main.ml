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

let display_data width data =
    for i = 0 to String.length data - 1 do
        if i <> 0 && i mod width = 0 then
            print_newline ();
        Printf.printf "%c" (String.get data i)
    done


let () =
    let filename = Sys.argv.(1) in
    let blocks = parse_file filename in
    let minipng = blocks_to_minipng blocks in
    display_header minipng.header;
    Printf.printf "Comments:\n\"%s\"\n" minipng.comment;
    display_data minipng.header.width (transform_string minipng.data);
