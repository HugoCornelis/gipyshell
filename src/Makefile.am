


AM_CFLAGS=-g3 -fPIC -Wmissing-prototypes -Wmissing-declarations -Wno-declaration-after-statement -DPRE_PROTO_TRAVERSAL @PYTHON_INCLUDE@ @PYTHON_CFLAGS@ @PERL_CCOPTS@ -I$(top_builddir)

pkglib_LIBRARIES = libgipyshell.a

libgipyshell_a_SOURCES = \
	header.c


bin_PROGRAMS = gipy

gipy_LDADD = -L. -lgipyshell @PYTHON_LDFLAGS@ @PERL_LDADD@

gipy_SOURCES = main.c

gipy_DEPENDENCIES = $(gipy_SOURCES) libgipyshell.a

gipy_LDFLAGS=-lm @PERL_LDFLAGS@


