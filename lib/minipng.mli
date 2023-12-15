type block_type = Header | Comment | Data
type header = { width : int; height : int; pixel_type : int; }
type block = Header of header | Comment of string | Data of string
type minipng = { header : header; comment : string; data : string; }

val parse_file : string -> block list
val blocks_to_minipng : block list -> minipng
val display_header : minipng -> string
val display_data : minipng -> string
val display_comment : minipng -> string