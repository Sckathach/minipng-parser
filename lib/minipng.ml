(*
 /\_/\
( o.o )
 > ^ <
*)

type block_type = Header | Comment | Data

type header = {
    width: int;
    height: int;
    pixel_type: int;
}

type block =
    Header of header
    | Comment of string
    | Data of string

type minipng = {
    header: header;
    comment: string;
    data: string;
}

let blocks_to_minipng blocks =
    let rec aux blocks header comment data = match blocks with
        [] -> { header = header; comment = comment; data = data }
        | Header h :: t -> aux t h comment data
        | Comment c :: t -> aux t header (comment ^ c) data
        | Data d :: t -> aux t header comment (data ^ d)
    in aux blocks { width = 1; height = 1; pixel_type = 0 } "" ""


let int_to_binary_string n =
    if n < 0 || n > 255 then
        invalid_arg "Number must be between 0 and 255";
    let rec aux n acc i =
        if i = 8 then acc
        else aux (n lsr 1) ((string_of_int (n land 1)) ^ acc) (i + 1)
    in
    aux n "" 0

let data_to_binary_string data =
    let rec aux acc = function
        [] -> acc
        | x :: q -> aux ((int_to_binary_string x) ^ acc) q
    in
        aux "" data

let binary_to_image binary_string =
    String.map (fun c -> if c = '1' then ' ' else '*') binary_string
let transform_string s =
    String.map (fun c -> if c = '0' then '*' else ' ') s

let read_int_from_bytes ic n =
    let rec read_bytes ic n acc =
        if n = 0 then acc
        else
            let byte = input_byte ic in
            read_bytes ic (n - 1) (acc + byte * (int_of_float (255. ** (float_of_int (n - 1)))))
    in
        read_bytes ic n 0


let read_block first_char ic =
    let block_type_char = first_char in
    let block_length = read_int_from_bytes ic 4 in
    match block_type_char with
        | 'H' ->
            let width = input_binary_int ic in
            let height = input_binary_int ic in
            let pixel_type = input_byte ic in
            Header { width; height; pixel_type }
        | 'C' ->
            Comment (really_input_string ic block_length)
        | 'D' ->
            let rec aux ic n acc = match n with
                0 -> acc
                | n -> aux ic (n - 1) ((input_byte ic) :: acc)
            in
                Data (data_to_binary_string (aux ic block_length []))
        | _ -> failwith "Unknown block type"

let read_magic_number ic =
    let magic_number = really_input_string ic 8 in
    if magic_number <> "Mini-PNG" then
        failwith "Invalid magic number"

let parse_file filename =
    let ic = open_in_bin filename in
    try
        read_magic_number ic;
        let rec loop blocks =
            match input_char ic with
                exception End_of_file -> blocks
                | first_char ->
                    let block = read_block first_char ic in
                    loop (block :: blocks)
        in
        let blocks = loop [] in
        close_in_noerr ic;
        List.rev blocks
    with e ->
        close_in_noerr ic;
    raise e

let display_header minipng =
    let header = minipng.header in
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

let display_data minipng =
    let width = minipng.header.width in
    let data = transform_string minipng.data in
    let result = ref "" in
    for i = 0 to String.length data - 1 do
        if i <> 0 && i mod width = 0 then
            result := !result ^ "\n" ;
        result := !result ^ Printf.sprintf "%c" (String.get data i)
    done;
    !result

let display_comment minipng =
    Printf.sprintf "Comments:\n\"%s\"\n" minipng.comment