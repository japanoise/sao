# sao - dynamic window manager
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c sao.c util.c
OBJ = ${SRC:.c=.o}

all: options sao

options:
	@echo sao build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	@echo creating $@ from config.def.h
	@cp config.def.h $@

sao: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f sao ${OBJ} sao-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p sao-${VERSION}
	@cp -R LICENSE TODO BUGS Makefile README config.def.h config.mk \
		sao.1 drw.h util.h ${SRC} sao.png transient.c sao-${VERSION}
	@tar -cf sao-${VERSION}.tar sao-${VERSION}
	@gzip sao-${VERSION}.tar
	@rm -rf sao-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f sao ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/sao
	@echo installing manual page to ${DESTDIR}${MANPREFIX}/man1
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@sed "s/VERSION/${VERSION}/g" < sao.1 > ${DESTDIR}${MANPREFIX}/man1/sao.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/sao.1

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/sao
	@echo removing manual page from ${DESTDIR}${MANPREFIX}/man1
	@rm -f ${DESTDIR}${MANPREFIX}/man1/sao.1

.PHONY: all options clean dist install uninstall
