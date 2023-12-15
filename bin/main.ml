open Minipng

(* The cat that protects the code from bugs

    |\__/,|   (`\
  _.|o o  |_   ) )
-(((---(((--------
*)

let display_header header =
    let result = ref "" in
    result := !result ^ Printf.sprintf "Width: %d\n" header.width;
    result := !result ^ Printf.sprintf "Height: %d\n" header.height;
    result := !result ^ Printf.sprintf "Pixel Type: %d " header.pixel_type;
    begin
        match header.pixel_type with
            0 -> result := !result ^ "(black-and-white)\n"
            | _ -> result := !result ^ "(other types not implemented)\n"
    end;
    !result

let display_data width data =
    let result = ref "" in
    for i = 0 to String.length data - 1 do
        if i <> 0 && i mod width = 0 then
            result := !result ^ "\n" ;
        result := !result ^ Printf.sprintf "%c" (String.get data i)
    done;
    !result

let display_comment comment =
    Printf.sprintf "Comments:\n\"%s\"\n" comment


let () =
(*    let filename = Sys.argv.(1) in *)
    let filename = "minipng-samples/bw/ok/A.mp" in
    let blocks = parse_file filename in
    let minipng = blocks_to_minipng blocks in
    Printf.printf "%s" (display_header minipng.header);
    Printf.printf "%s" (display_comment minipng.comment);
    Printf.printf "%s" (display_data minipng.header.width (transform_string minipng.data));
