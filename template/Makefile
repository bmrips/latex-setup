DOCUMENTS ?= main.pdf

.PHONY : all clean cleanall

all : $(DOCUMENTS)

%.pdf : %.tex
	latexmk -use-make $<

clean :
	@luaotfload-tool --cache=erase --flush-lookups --force
	@shopt -s globstar && rm -rf **/*~[0-9]* **/*.[1-9] **/*.[1-9][0-9] **/*.[1-9][0-9][0-9] **/*.[1-9][0-9][0-9]R **/*.[1-9][0-9]R **/*.[1-9]R **/*.4ct **/*.4tc **/*.acn **/*.acr **/acs-*.bib **/*.alg **/./auto/* **/*.aux **/*.auxlock **/*.backup **/*.bak **/*.bbl **/*.bcf **/*.blg **/*-blx.aux **/*-blx.bib **/*.brf **/*.cb **/*.cb2 **/*-concordance.tex **/*-converted-to.* **/*.cpt **/*.cut **/*.dpth **/*.dvi **/*.el **/*.eledsec[1-9] **/*.eledsec[1-9][0-9] **/*.eledsec[1-9][0-9][0-9] **/*.eledsec[1-9][0-9][0-9]R **/*.eledsec[1-9][0-9]R **/*.eledsec[1-9]R **/*.?end **/*.end **/*.ent **/*.fdb_latexmk **/*.fff **/*.fls **/*.fmt **/*.fot **/*.gaux **/*.glg **/*.glo **/*.gls **/*.glsdefs **/*-gnuplottex-* **/*.gtex **/*.hst **/*.idv **/*.idx **/*.ilg **/*.ind **/latex.out/ **/.*.lb **/*.lg **/*.listing **/*.loa **/*.lod **/*.loe **/*.lof **/*.log **/*.lol **/*.lot **/*.lox **/*.lpz **/*.ltjruby **/*.lyx~ **/*.lzo **/*.lzs **/*.maf **/*.md5 **/*.mf **/_minted* **/*.mlf **/*.mlt **/*.mp **/*.mtc[0-9]* **/*.mw **/*.nav **/*.nlg **/*.nlo **/*.nls **/*.out **/*.pax **/*.pre **/*.pyg **/pythontex-files-*/ **/*.pytxcode **/*.run.xml **/*.sagetex.py **/*.sagetex.sage **/*.sagetex.scmd **/*.sav **/*.slf[0-9]* **/*.slt[0-9]* **/*.snm **/*.soc **/*.sout **/*.spl **/*.sta **/*.stc[0-9]* **/.*.swp **/*.sympy **/sympy-plots-for-*.tex/ **/*.synctex **/*.synctex\(busy\) **/*.synctex.gz **/*.synctex.gz\(busy\) **/*.t[1-9] **/*.t[1-9][0-9] **/*-tags.tex **/*.tdo **/.texpadtmp **/*.tfm **/*.thm **/*-tikzDictionary **/*.toc **/*.tps **/*.trc **/TSWLatexianTemp* **/*.ttt **/*.lpc **/*.upa **/*.upb **/*.ver **/*.vrb **/*.wrt **/*.xcp **/*.xdv **/*.xdy **/*.xmpi **/*.xref **/*.xsim **/*.xwm **/*.xyc **/*.xyd

cleanall : clean
	rm -f $(DOCUMENTS)

install: $(DOCUMENTS)
	install -Dt ${out} $^
