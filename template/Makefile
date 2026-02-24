DOCUMENTS ?= main.pdf

.PHONY : all clean cleanall

all : $(DOCUMENTS)

%.pdf : %.tex
	latexmk -use-make $<

clean :
	@luaotfload-tool --cache=erase --flush-lookups --force
	@shopt -s globstar && rm -rf '*-blx.aux' '*-blx.bib' '*-concordance.tex' '*-converted-to.*' '*-gnuplottex-*' '*-tags.tex' '*-tikzDictionary' '*.4ct' '*.4tc' '*.?end' '*.[1-9]' '*.[1-9][0-9]' '*.[1-9][0-9][0-9]' '*.[1-9][0-9][0-9]R' '*.[1-9][0-9]R' '*.[1-9]R' '*.acn' '*.acr' '*.alg' '*.aux' '*.auxlock' '*.bbl' '*.bcf' '*.blg' '*.brf' '*.cb' '*.cb2' '*.cpt' '*.cut' '*.dpth' '*.dvi' '*.eledsec[1-9]' '*.eledsec[1-9][0-9]' '*.eledsec[1-9][0-9][0-9]' '*.eledsec[1-9][0-9][0-9]R' '*.eledsec[1-9][0-9]R' '*.eledsec[1-9]R' '*.end' '*.ent' '*.fdb_latexmk' '*.fff' '*.fls' '*.fmt' '*.fot' '*.gaux' '*.glg' '*.glo' '*.glog' '*.gls' '*.glsdefs' '*.gnuplot' '*.gtex' '*.hst' '*.idv' '*.idx' '*.ilg' '*.ind' '*.lg' '*.listing' '*.loa' '*.lod' '*.loe' '*.lof' '*.log' '*.lol' '*.lot' '*.lox' '*.lpc' '*.lpz' '*.ltjruby' '*.lzo' '*.lzs' '*.maf' '*.md5' '*.mf' '*.mlf' '*.mlt' '*.mp' '*.mtc[0-9]*' '*.mw' '*.nav' '*.newpax' '*.nlg' '*.nlo' '*.nls' '*.out' '*.pax' '*.pdfpc' '*.pdfsync' '*.pre' '*.ptc' '*.pyg' '*.pytxcode' '*.run.xml' '*.sagetex.py' '*.sagetex.sage' '*.sagetex.scmd' '*.slf[0-9]*' '*.slg' '*.slo' '*.sls' '*.slt[0-9]*' '*.snm' '*.soc' '*.sout' '*.spl' '*.sta' '*.stc[0-9]*' '*.sympy' '*.synctex' '*.synctex(busy)' '*.synctex.gz' '*.synctex.gz(busy)' '*.t[1-9]' '*.t[1-9][0-9]' '*.table' '*.tdo' '*.tfm' '*.thm' '*.toc' '*.trc' '*.ttt' '*.upa' '*.upb' '*.ver' '*.vrb' '*.wrt' '*.xcp' '*.xdv' '*.xdy' '*.xmpi' '*.xref' '*.xwm' '*.xyc' '*.xyd' '.*.lb' '.pdf' '_minted*' 'acs-*.bib' 'latex.out/' 'pythontex-files-*/' 'svg-inkscape/' 'sympy-plots-for-*.tex/'

cleanall : clean
	rm -f $(DOCUMENTS)

install: $(DOCUMENTS)
	install -Dt ${out} $^
