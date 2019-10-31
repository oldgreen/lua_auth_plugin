CFLAGS = -std=gnu99 -fPIC `pkg-config --cflags lua5.3` -Wall -Wextra -O2
LIBS = `pkg-config --libs lua5.3` `pkg-config --libs libmosquitto`
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
