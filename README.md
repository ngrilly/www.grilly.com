My personal website.

Install dependencies:

    $ brew install caddy gettext translate-toolkit

Serve locally:

    $ caddy file-server

# Translations

Extract translatable strings and update .po files:

    $ make

Launch poedit:

- Open `po/en.po`
- Translate
- Save and quit

Update HTML pages with the new translations:

    $ make

# Inspiring personal websites

- http://hugo.io/
- https://campoy.cat/

# Todo

- Replace email icon with email address in plain text?
- Fix po2html:
    - Fix missing doctype in po2html output (implementing handle_decl in https://github.com/translate/translate/blob/master/translate/storage/html.py)
    - Fix untranslated lang attribute in po2html output
- Add Facebook OpenGraph / Twitter card tags

# Done

- SEO