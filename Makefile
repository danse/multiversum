all: site
	./site build

site: site.hs
	ghc $^

fonts/sudo.zip:
	wget http://www.netzallee.de/extra/downloads/sudo.zip -O $@
