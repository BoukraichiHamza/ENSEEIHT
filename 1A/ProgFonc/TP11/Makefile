OCAMLC=ocamlc
OCAMLOPT=ocamlopt
OCAMLDEP=ocamldep

all: depend appli

.SUFFIXES: .mli .ml .cmi .cmo

Iappli=tas.cmi
Oappli=tas.cmo appli.cmo

appli: $(Iappli) $(Oappli)
	$(OCAMLC) -o $@ $(Oappli)

.mli.cmi :
	$(OCAMLC) -c $<

.ml.cmo :
	$(OCAMLC) -c $<

clean:
	rm -f *.cmi *.cmo appli

# Dependencies
depend:
	$(OCAMLDEP) *.mli *.ml > .depend

include .depend
