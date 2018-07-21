CFLAGS = -std=gnu99 -fPIC -I/usr/include/lua5.3 -Wall -Wextra -O2
LIBS = -llua5.3 -lmosquitto
DESTDIR = /usr/local

all : lua_auth_plugin.so

.c.o:
	$(CC) $(CFLAGS) -c -o $@ $<

lua_auth_plugin.so : lua_auth_plugin.o
	$(CC) $(CFLAGS) -shared -o $@ $^  $(LIBS)

install: lua_auth_plugin.so
	install -s -m 755 lua_auth_plugin.so $(DESTDIR)/lib

clean :
	rm -f lua_auth_plugin.so *.o

.PHONY: all clean
