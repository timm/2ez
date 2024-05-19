SSHELL     := bash 
MAKEFLAGS += --warn-undefined-variables
.SILENT: 
Root=$(shell git rev-parse --show-toplevel)

help      :  ## show help
	awk 'BEGIN {FS = ":.*?## "; print "\nmake [WHAT]" } \
			/^[^[:space:]].*##/ {printf "   \033[36m%-15s\033[0m : %s\n", $$1, $$2} \
			' $(MAKEFILE_LIST)

saved     : ## save and push to main branch 
	read -p "commit msg> " x; x=$${x:-saved};  git commit -am "$$x}"; git push;  git status; echo "[$$x], committed!"

name:
	read -p "word> " w; figlet -f mini -W $$w  | gawk '$$0 {print "#        "$$0}' |pbcopy

install   : ## install as  a local python package
	pip install -e  . --break-system-packages 

docs/%.html : %.py %.png ## .py ==> .html
	mkdir -p $(dir $@)
	pycco -d $(dir $@) $<
	echo 'p {text-align: right;}' >> $(dir $@)/pycco.css
	sed -i '' 's/$< : /<img src="$(basename $<).png" align=left width=170>&/' $@
	cp $(basename $<).png $(dir $@)
	open $@

~/tmp/%.pdf: %.py  ## .py ==> .pdf
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

