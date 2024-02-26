all: po/en.po content/_index.md

po/en.po: po/strings.pot
	msgmerge --update --previous --backup=off $@ $<

po/strings.pot: content/_index.fr.md
	html2po --pot --input=$< --output=$@

content/_index.md: content/_index.fr.md po/en.po
	po2html --template=content/_index.fr.md --input=po/en.po --output=$@