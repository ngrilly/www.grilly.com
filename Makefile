all: po/strings.pot public/en/index.html

po/strings.pot: public/fr/index.html
	html2po --pot --input=$< --output=$@

public/en/index.html: public/fr/index.html po/en.po
	po2html --template=public/fr/index.html --input=po/en.po --output=$@