# st - simple terminal
# See LICENSE file for copyright and license details.

include config.mk

SRC = st.c
OBJ = ${SRC:.c=.o}

all: options st-solarized-dark

options:
	@echo st build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

config.h:
	cp config.def.h config.h

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

st-solarized-dark: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f st-solarized-dark ${OBJ}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f st-solarized-dark ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/st-solarized-dark
	@echo Please see the README file regarding the terminfo entry of st.
	@tic -s st.info

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/st-solarized-dark

.PHONY: all options clean dist install uninstall
