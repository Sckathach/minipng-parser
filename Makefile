all: build

build:
	dune build

test: 
	dune test 

publish:
	dune build 
	cp _build/default/bin/main.exe main.exe
