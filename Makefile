all: public/en/index.html

po/strings.pot: public/fr/index.html
	html2po --pot --input=$< --ouput=$@

public/en/index.html: po/en.po
	po2html --template=public/fr/index.html --input=$< --output=$@