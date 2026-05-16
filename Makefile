CC = g++
CXX = g++

# Compiler flags
CXXFLAGS = -g -O2 -Wall -fPIC -fstack-protector-strong \
           -D_FORTIFY_SOURCE=2 -Iinclude

# Linker flags
LDFLAGS = -lcurl -lcrypto -lssl -lpam

# Installation paths
libdir.x86_64 = /usr/lib/security
libdir.i686   = /usr/lib/security

MACHINE := $(shell uname -m)
libdir = $(libdir.$(MACHINE))

target = pam_privacyidea.so
objects = src/pam_privacyidea.o src/privacyidea.o

all: $(target)

%.o: %.cpp
	$(CXX) -c $(CXXFLAGS) $< -o $@

$(target): $(objects)
	$(CXX) -shared -o $@ $^ $(LDFLAGS)
	@echo "Built: $@"

clean:
	rm -f src/*.o $(target)

install: all
	@echo "Installing to $(libdir)"
	strip --strip-unneeded $(target)
	sudo cp $(target) $(libdir)/
	sudo chmod 644 $(libdir)/$(target)
	sudo ldconfig
	@echo "Installation completed."

uninstall:
	sudo rm -f $(libdir)/$(target)
	sudo ldconfig

.PHONY: all clean install uninstall