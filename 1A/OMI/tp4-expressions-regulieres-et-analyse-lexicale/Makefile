
OCAMLLEX = ocamllex
OCAMLYACC = ocamlyacc
OCAMLC=ocamlc
OCAMLLD=ocamlc


.SUFFIXES: .ml .mli .cmo .cmi .mll .mly

%.cmi : %.mli
	$(OCAMLC) -c $<

%.cmo : %.ml %.cmi
	$(OCAMLC) -c $<

%.cmo : %.ml
	$(OCAMLC) -c $<

%.cmo : %.cmi
	$(OCAMLC) -c $<

%.ml : %.mll
	$(OCAMLLEX) $<

%.mli %.ml : %.mly
	$(OCAMLYACC) $<

all : mainJava

lexerJava.ml : tokenJava.cmi

tokenJava.ml : tokenJava.cmi

lexerJava.cmo : lexerJava.ml

mainJava : tokenJava.cmo lexerJava.cmo mainJava.cmo
	$(OCAMLC) -o MainJava str.cma tokenJava.cmo lexerJava.cmo mainJava.cmo

clean :
	-rm -f *.cmo *.cmi lexerJava.ml MainJava
