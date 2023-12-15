# MiniPNG Parser
CSC4203 project: create a parser for a custom type, the Mini-PNG. The instructions are written here: 
[minipng.pdf](minipng.pdf)

## Use 
### Using the executable 
```shell
./main.exe minipng-samples/bw/ok/A.mp
```

### From source 
```shell
dune build 
./_build/default/bin/main.exe minipng-samples/bw/ok/A.mp
```

## Test 
### Using dune 
&rarr; tests are not yet functional...
```shell
dune test 
```

## Install the tools to compile/ debug OCaml code
### Install Opam
#### Archlinux 
```shell
pacman -S opam

eval $(opam env)

opam install dune merlin ocaml-lsp-server odoc ocamlformat utop dune-release ppx_inline_test
```

#### Ubuntu 
```shell
add-apt-repository ppa:avsm/ppa
apt update
apt install opam

eval $(opam env)

opam install dune merlin ocaml-lsp-server odoc ocamlformat utop dune-release
```