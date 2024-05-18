saved:
	git commit -am as; git push; git status

~/tmp/%.html : %.py %.png
	mkdir -p $(dir $@)
	pycco -d $(dir $@) $<
	echo 'p {text-align: right;}' >> $(dir $@)/pycco.css
	sed -i '' 's/$< : /<img src="$(basename $<).png" align=left width=170>&/' $@
	cp $(basename $<).png $(dir $@)
	open $@

~/tmp/%.pdf: %.py  ## .lua ==> .pdf
	mkdir -p $(dirname $@)
	echo "pdf-ing $@ ... "
	a2ps                 \
		-Br                 \
		--chars-per-line 100  \
		--file-align=fill      \
		--line-numbers=1        \
		--borders=no             \
		--pro=color               \
		--left-title=""            \
		--columns  3                 \
		-M letter                     \
		--footer=""                    \
		--right-footer=""               \
	  -o	 $@.ps $<
	ps2pdf $@.ps $@; rm $@.ps    
	open $@

