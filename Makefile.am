##
## The neurospaces project : modeling tools for computational
## neuroscience.
##

##############################################################################
##'
##' The neurospaces project
##'
##' Copyright (C) 2007-2008 Hugo Cornelis
##'
##' Hugo Cornelis, hugo.cornelis@gmail.com
##'
##############################################################################


SUBDIRS = # src # perl python

# fill in the scripts that should go with the distribution:
dist_bin_SCRIPTS = \
	bin/gipyshell \
	bin/gipyshell-sync \
	bin/gipyshell-version

@PACKAGE@testdir=$(prefix)/neurospaces/$(PACKAGE)
nobase_dist_@PACKAGE@test_DATA=@TEST_SPECIFICATION_FILES@

@PACKAGE@profiledir=$(prefix)/neurospaces/$(PACKAGE)
nobase_dist_@PACKAGE@profile_DATA=@IPYTHON_PROFILE_FILES@


RELEASE_MAJOR=`release-extract --major`
RELEASE_MINOR=`release-extract --minor`
RELEASE_MICRO=`release-extract --micro`

show-release-labels:
	echo "Release information (major-minor-micro): $(RELEASE_MAJOR)-$(RELEASE_MINOR)-$(RELEASE_MICRO)"

dist-keywords:
	release-expand $(PACKAGE) $(RELEASE_MAJOR) $(RELEASE_MINOR) $(RELEASE_MICRO) $(RELEASE_MAJOR).$(RELEASE_MINOR) hugo.cornelis@gmail.com --verbose

# the tests are copied overhere.
#
# The variable EXTRA_DIST could also be used here.

EXTRA_DIST = \
	docs \
	tests \
	license.txt

am__tar = ${AMTAR} chf - --format=posix "$$tardir"


clean-local:
	rm -rf $(TMP_DIR)
	$(RM) -rf $(top_srcdir)/*.deb
	$(RM) -f $(top_srcdir)/*.changes
	$(RM) -f $(top_srcdir)/*.dsc
	$(RM) -f $(top_srcdir)/build_*.log
	$(RM) -rf $(top_srcdir)/*_BUILD/
	$(RM) $(top_srcdir)/$(PACKAGE)-*.tar.gz

dist-hook: 
	$(srcdir)/install-sh -d $(distdir)/tests
	$(srcdir)/install-sh -d $(distdir)/tests/html
	( cd $(distdir)/tests && chmod -R u+w . && neurospaces_harness_2_html --introduction introduction.html )

#install-data-local: neurospaces_cpan_modules

#neurospaces_cpan_modules:
#	@echo "======================== Installing CPAN modules"
#	( cd cpan ; ./cpan_install *.gz )
#	touch $(top_srcdir)/neurospaces_cpan_modules

install-exec-local:
	( cd $(bindir) ; for script in `ls heterarch-* | grep -v version | grep -v sync | grep -v pull | grep -v push` ; do ln -vsf {heterarch,gipyshell}-`echo $$script | cut -f2- -d-` ; done )
	( cd $(bindir) ; for script in `ls heterarch_* | grep -v version | grep -v sync | grep -v pull | grep -v push` ; do ln -vsf {heterarch,gipyshell}_`echo $$script | cut -f2- -d_` ; done )

uninstall-local:
	( cd $(bindir) ; echo gipyshell[_-]* ; $(RM) gipyshell[_-]* )

test: check

#TESTS = $(srcdir)/tests/neurospaces_harness

html-upload-prepare:
	( cd tests && neurospaces_harness_2_html --introduction introduction.html )
	$(srcdir)/install-sh -d html
	$(srcdir)/install-sh -d html/htdocs
	$(srcdir)/install-sh -d html/htdocs/neurospaces_project
	$(srcdir)/install-sh -d html/htdocs/neurospaces_project/gipyshell
	$(srcdir)/install-sh -d html/htdocs/neurospaces_project/gipyshell/html_source
	tar cfh - tests/html | ( cd html/htdocs/neurospaces_project/gipyshell && tar vxf - )

html-upload: html-upload-prepare
	scp -pr html/htdocs/* hcornelis,neurospaces@web.sourceforge.net:/home/groups/n/ne/neurospaces/htdocs/

website-clean:
	$(RM) -fr html/htdocs/neurospaces_project/gipyshell/

website-prepare:
	gipyshell-build --tags published

website-prepare-local:
	gipyshell-build --tags local --tags published

website-upload: website-clean website-prepare html-upload

webcheck:
	rm -rf html/htdocs/neurospaces_project/gipyshell/webcheck
	mkdir html/htdocs/neurospaces_project/gipyshell/webcheck
	webcheck -o html/htdocs/neurospaces_project/gipyshell/webcheck html/htdocs/neurospaces_project/gipyshell --redirects=10

docs-level1:

docs-level2:

docs-level3: html-upload-prepare
	echo "Converted the regression tests to HTML"

docs-level4:

docs-level5:

docs-level6:

docs-level7:

docs: docs-level1 docs-level2 docs-level3 docs-level4 docs-level5 docs-level6 docs-level7

APP_NAME=neurospaces$(PACKAGE)

# the pkg-src target must create pkg/$(APP_NAME)-$(VERSION).tar.gz
pkg-src: dist
	mkdir -p pkg
	cp $(PACKAGE)-$(VERSION).tar.gz pkg/$(PACKAGE)-$(VERSION).tar.gz


# Create a deb package
pkg-deb: dist
	nspkg-deb $(PACKAGE) $(VERSION)

pkg-rpm: dist
	nspkg-rpm $(PACKAGE) $(VERSION)

pkg-osx: 
	nspkg-osx 
