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

let rec print_int_list = function
    [] -> ()
    | x :: q -> Printf.printf "%d " x; print_int_list q

let display_data width height data =
    let rec aux x y data = match x, y, data with
        | x, _ , _ when x >= width / 8 ->
            print_newline ();
            aux 0 (y + 1) data
        | x, y, _ when x >= width && y >= height -> ()
        | _, _, [] -> ()
        | _, _, t :: q ->
            Printf.printf "%s" (binary_to_image (int_to_binary_string t));
            aux (x + 1) y q
    in
        aux 1 1 (List.rev data)

let () =
    let filename = Sys.argv.(1) in
    let blocks = parse_file filename in
    let rec aux width height = function
        [] -> ()
        | (Header header) :: q ->
            display_header header;
            aux header.width header.height q
        | (Comment comment) :: q ->
            Printf.printf "Comments:\n\"%s\"\n" comment;
            aux width height q
        | (Data data) :: q ->
(*            print_int_list data; *)
(*            print_endline ""; *)
            display_data width height data;
            aux width height q
    in
        aux 0 0 blocks