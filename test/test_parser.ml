open Lib.Minipng
open Filename

(*Idk why it doesn't work with relative PATH...*)
let path = "/mnt/Documents/INT/TSP/Cours/2A/csc4203/parser/test/minipng-samples/"

let%test "wrong magic" =
    let filename = path ^ "bw/ok/A.mp" in
    try
        let blocks = parse_file filename in
        true
    with
        Failure x ->
            x = "Invalid magic number"

let%test _ = true