My personal website.

Install dependencies:

    $ brew install caddy translate-toolkit

Serve locally:

    $ caddy

# Translations

Extract strings and update the .pot template:

    $ make

Launch poedit:

- Open `po/en.po`
- Update strings with the template `po/strings.pot`
- Translate
- Save and quit

Update HTML pages with the new translations:

    $ make

# Inspiring personal websites

- http://hugo.io/
- https://campoy.cat/

# Todo

- Replace email icon with email address in plain text
- Fix missing doctype in po2html output (implementing handle_decl in https://github.com/translate/translate/blob/master/translate/storage/html.py)
- Fix untranslated lang attribute in po2html output
- Fix redirection from blog.grilly.com
- SEO