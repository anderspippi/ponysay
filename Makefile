all: ponysaytruncater manpages

ponysaytruncater:
	gcc -o "ponysaytruncater" "ponysaytruncater.c"

manpages:
	gzip -9 < manuals/manpage.6 > manuals/manpage.6.gz
	gzip -9 < manuals/manpage.es.6 > manuals/manpage.es.6.gz

ttyponies:
	mkdir -p ttyponies
	./ttyponies.sh

install: all
	mkdir -p "$(DESTDIR)/usr/share/ponysay/"
	mkdir -p "$(DESTDIR)/usr/share/ponysay/ponies"
	mkdir -p "$(DESTDIR)/usr/share/ponysay/ttyponies"
	cp ponies/*.pony "$(DESTDIR)/usr/share/ponysay/ponies/"
	cp ttyponies/*.pony "$(DESTDIR)/usr/share/ponysay/ttyponies/"

	mkdir -p "$(DESTDIR)/usr/bin/"
	install "ponysay" "$(DESTDIR)/usr/bin/ponysay"
	install -s "ponysaytruncater" "$(DESTDIR)/usr/bin/ponysaytruncater"
	ln -sf "ponysay" "$(DESTDIR)/usr/bin/ponythink"

	mkdir -p "$(DESTDIR)/usr/share/zsh/site-functions/"
	install "completion/zsh-completion.zsh" "$(DESTDIR)/usr/share/zsh/site-functions/_ponysay"

	mkdir -p "$(DESTDIR)/usr/share/bash-completion/completions/"
	install "completion/bash-completion.sh" "$(DESTDIR)/usr/share/bash-completion/completions/ponysay"

	mkdir -p "$(DESTDIR)/usr/share/licenses/ponysay/"
	install "COPYING" "$(DESTDIR)/usr/share/licenses/ponysay/COPYING"

	mkdir -p "$(DESTDIR)/usr/share/man/man6"
	install "manuals/manpage.6.gz" "$(DESTDIR)/usr/share/man/man6/ponysay.6.gz"
	ln -sf "ponysay.6.gz" "$(DESTDIR)/usr/share/man/man6/ponythink.6.gz"

	mkdir -p "$(DESTDIR)/usr/share/man/es/man6"
	install "manuals/manpage.es.6.gz" "$(DESTDIR)/usr/share/man/es/man6/ponysay.6.gz"
	ln -sf "ponysay.6.gz" "$(DESTDIR)/usr/share/man/es/man6/ponythink.6.gz"

	@echo -e '\n\n'\
'/--------------------------------------------------\\\n'\
'|   ___                                            |\n'\
'|  / (_)        o                                  |\n'\
'|  \__   _  _      __                              |\n'\
'|  /    / |/ |  | /  \_|   |                       |\n'\
'|  \___/  |  |_/|/\__/  \_/|/                      |\n'\
'|              /|         /|                       |\n'\
'|              \|         \|                       |\n'\
'|   ____                                           |\n'\
'|  |  _ \  ___   _ __   _   _  ___   __ _  _   _   |\n'\
'|  | |_) |/ _ \ | '\''_ \ | | | |/ __| / _` || | | |  |\n'\
'|  |  __/| (_) || | | || |_| |\__ \| (_| || |_| |  |\n'\
'|  |_|    \___/ |_| |_| \__, ||___/ \__,_| \__, |  |\n'\
'|                       |___/              |___/   |\n'\
'\\--------------------------------------------------/'
	@echo '' | ./ponysay -f ./`if [[ "$$TERM" = "linux" ]]; then echo ttyponies; else echo ponies; fi`/pinkiecannon.pony | tail --lines=30 ; echo -e '\n'

uninstall:
	rm -fr "$(DESTDIR)/usr/share/ponysay/ponies"
	rm -fr "$(DESTDIR)/usr/share/ponysay/ttyponies"
	unlink "$(DESTDIR)/usr/bin/ponysay"
	unlink "$(DESTDIR)/usr/bin/ponysaytruncater"
	unlink "$(DESTDIR)/usr/bin/ponythink"
	unlink "$(DESTDIR)/usr/share/zsh/site-functions/_ponysay";
	unlink "$(DESTDIR)/usr/share/licenses/ponysay/COPYING"
	unlink "$(DESTDIR)/usr/share/bash-completion/completions/ponysay"
	unlink "$(DESTDIR)/usr/share/man/man6/ponysay.6.gz"
	unlink "$(DESTDIR)/usr/share/man/man6/ponythink.6.gz"
	unlink "$(DESTDIR)/usr/share/man/es/man6/ponysay.6.gz"
	unlink "$(DESTDIR)/usr/share/man/es/man6/ponythink.6.gz"

clean:
	rm -f "ponysaytruncater"
	rm manuals/manpage.6.gz
	rm manuals/manpage.es.6.gz

