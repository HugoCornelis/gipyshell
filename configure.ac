dnl -*- autoconf -*-
dnl
dnl The neurospaces project : modeling tools for computational
dnl neuroscience.
dnl

dnl ##########################################################################
dnl 
dnl The neurospaces project
dnl 
dnl Copyright (C) 2007-2008 Hugo Cornelis
dnl 
dnl Hugo Cornelis, hugo.cornelis@gmail.com
dnl 
dnl ##########################################################################

# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.59)

# $Format: "AC_INIT(${package}, ${major}.${minor}.${micro}-${label}, ${email})"$
AC_INIT(gipyshell, 0.0.0-alpha, hugo.cornelis@gmail.com)



AC_MSG_CHECKING(whether we build universal binaries.)
AC_ARG_WITH(universal,
[AS_HELP_STRING([--with-universal],
              [Build universal binaries on Mac OS X.])],
[ case "$val" in
  no)

    AC_MSG_RESULT(no)
    OSX_UNIVERSAL="no"

    ;;
  *)

    AC_MSG_RESULT(yes)
    OSX_UNIVERSAL="yes"

    ;;
  esac ],
  AC_MSG_RESULT(no)
  OSX_UNIVERSAL="no"
)
AC_SUBST(OSX_UNIVERSAL)

dnl -----------------------------------------------------
dnl Set flags for specific cpus
dnl -----------------------------------------------------
AC_MSG_CHECKING([checking CPU])
case "$host_cpu" in

	i[[3456]]86|pentium)
	  AC_MSG_RESULT([Intel based CPU])
	;;
	x86?64*)
	  dnl
	  dnl The test machine sorts an AMD 64 bit cpu
	  dnl this need fPIC set globally for all compiled objects
	  dnl for swig to work.
	  AC_MSG_RESULT([AMD 64 based CPU])
 	  CFLAGS="$CFLAGS -fPIC"
	;;
	*)
	  AC_MSG_RESULT([Unknown CPU type])
	;;
esac



AC_CONFIG_SRCDIR([Makefile.am])

dnl dnl all subdirs

dnl AC_CONFIG_SUBDIRS()

# $Format: "AM_INIT_AUTOMAKE(${package}, ${major}.${minor}.${micro}-${label})"$
AM_INIT_AUTOMAKE(gipyshell, 0.0.0-alpha)

PERL_MODULES=`(cd perl && find . -name "*.pm" | perl -pe 's/\n/ /g')`
AC_SUBST(PERL_MODULES)

PERL_DATA=`(cd perl && find . -name "numbers-7x11.txt" | perl -pe 's/\n/ /g')`
AC_SUBST(PERL_DATA)

# Checks for programs.

AC_PROG_CC
AC_PROG_YACC
AC_PROG_LEX
AC_PROG_RANLIB
AC_PROG_CPP


AC_PATH_PROGS(DOXYGEN,doxygen,["NULL"])
AC_PATH_PROGS(DOT,dot,["NULL"])
AC_PATH_PROGS(SOURCE_HIGHLIGHT,source-highlight,["NULL"])

#   need to have this bail out when MTN = NULL
#   since it's required. 
AC_CHECK_PROGS([MTN],mtn monotone,[NULL])

#   check for packaging programs for debian and red hat.
#   no need to bail out if these are missing since they're optional. 
AC_CHECK_PROGS([DPKG_BUILDPACKAGE],dpkg-buildpackage,[NULL])
AC_CHECK_PROGS([DH],dh,[NULL])
AC_CHECK_PROGS([RPMBUILD],rpmbuild,[NULL])

dnl Check for Python and it's headers
AM_PATH_PYTHON(,[],[
   echo "Python is not installed."
   exit -1
])

AC_MSG_CHECKING([Python prefix is ])
  AC_MSG_RESULT(['$PYTHON_PREFIX'])

AC_ARG_VAR([PYTHON_CONFIG], [Path to python-config])
AC_ARG_VAR([PYTHON_INCLUDE], [Include flags for python, bypassing python-config])
AS_IF([test -z "$PYTHON_INCLUDE"], [
  AS_IF([test -z "$PYTHON_CONFIG"], [
    AC_PATH_PROGS([PYTHON_CONFIG],
                  [python$PYTHON_VERSION-config python-config],
                  [no],
                  [`dirname $PYTHON`])
    AS_IF([test "$PYTHON_CONFIG" = no], [AC_MSG_ERROR([cannot find python-config for $PYTHON.])])
  ])
  AC_MSG_CHECKING([python include flags])
  PYTHON_INCLUDE=`$PYTHON_CONFIG --includes`
  AC_MSG_RESULT([$PYTHON_INCLUDE])
])
AC_ARG_VAR([PYTHON_CFLAGS], [Compiler flags for python, bypassing python-config])
AS_IF([test -z "$PYTHON_CFLAGS"], [
  AS_IF([test -z "$PYTHON_CONFIG"], [
    AC_PATH_PROGS([PYTHON_CONFIG],
                  [python$PYTHON_VERSION-config python-config],
                  [no],
                  [`dirname $PYTHON`])
    AS_IF([test "$PYTHON_CONFIG" = no], [AC_MSG_ERROR([cannot find python-config for $PYTHON.])])
  ])
  AC_MSG_CHECKING([python include flags])
  PYTHON_CFLAGS=`$PYTHON_CONFIG --cflags`
  AC_MSG_RESULT([$PYTHON_CFLAGS])
])
AC_ARG_VAR([PYTHON_LDFLAGS], [Compiler flags for python, bypassing python-config])
AS_IF([test -z "$PYTHON_LDFLAGS"], [
  AS_IF([test -z "$PYTHON_CONFIG"], [
    AC_PATH_PROGS([PYTHON_CONFIG],
                  [python$PYTHON_VERSION-config python-config],
                  [no],
                  [`dirname $PYTHON`])
    AS_IF([test "$PYTHON_CONFIG" = no], [AC_MSG_ERROR([cannot find python-config for $PYTHON.])])
  ])
  AC_MSG_CHECKING([python include flags])
  PYTHON_LDFLAGS=`$PYTHON_CONFIG --ldflags`
  AC_MSG_RESULT([$PYTHON_LDFLAGS])
])


# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

# determine the test library to install

TEST_SPECIFICATION_FILES=`/bin/echo -n "tests/introduction.html " && find tests/specifications -name "*.t" | perl -pe 's/\n/ /g' && find tests/specifications/strings -name "*.txt" | perl -pe 's/\n/ /g' && find tests/data -name "*.yml" | perl -pe 's/\n/ /g'`
AC_SUBST(TEST_SPECIFICATION_FILES)

IPYTHON_PROFILE_FILES=`find ipython_profile/ -type f | perl -pe 's/\n/ /g'`
AC_SUBST(IPYTHON_PROFILE_FILES)


dnl This does macro substitutions for certain operating systems and 
dnl architectures 
AC_MSG_CHECKING([OS specifics...])
AC_MSG_RESULT([Host is running $host_os.])
dnl {{{
case "$host_os" in
  darwin*)

    #
    # These are settings specific to MAC OS X.
    #
    dnl {{{{


    # Check for libtool to make executables
    AC_MSG_CHECKING([Using libtool for MAC OS X.])
    AC_CHECK_PROG(LIBTOOL_PRESENT, libtool, yes, no)

    case $LIBTOOL_PRESENT in
      yes*)

        AR=libtool
        ARFLAGS='-static -c -o'
        AC_SUBST(AR)
        AC_SUBST(ARFLAGS)
        dnl AC_MSG_RESULT([$AR $ARFLAGS])

      ;;
      no*)

        AC_ERROR([libtool for Mac OSX is not found. It's needed to make executables.])

      ;;
    esac

    
    dnl On the MAC we will only look for perl in the standard location for the Apple
    dnl native perl. 
    dnl OLD LINE: AC_CHECK_PROG(PERL, perl, NULL, [/usr/bin/perl],[/usr/local/bin/perl /opt/local/bin/perl /sw/bin/perl])
    dnl AC_CHECK_PROG(PERL_PRESENT, perl,yes, no, [/usr/bin], [/usr/local/bin/perl /opt/local/bin/perl /sw/bin/perl])
    dnl AC_SUBST(PERL_PRESENT)

    dnl Going to restrict the search for perl to use the mac standard location
    AC_CHECK_PROGS(PERL, perl, [NULL], [/usr/bin])

    dnl AC_MSG_CHECKING([Checking the perl installation])
    case $PERL in
      NULL*)
        echo ""
        echo "Error, the standard version of perl for Mac OSX is not found."
        echo "Non standard versions of perl are known to cause problems."
        AC_ERROR([Perl for Mac OSX is not found.])
        ;;
        *)
        dnl Ensure that ONLY the standard mac perl is used throughout.
	PERL='/usr/bin/perl'
        AC_SUBST(PERL)
        ;;
dnl       *)

dnl         AC_MSG_RESULT([ $PERL ])

dnl         ;;
    esac



    #-- Here we determine the install path for perl modules --
    AC_MSG_CHECKING([Checking the perl module installation path])	
    pmdir_relative_path=`\
      $PERL -MConfig \
        -wle '($_ = $Config{installsitelib})
              =~ s!^\Q$Config{siteprefix}/!!; \
              print'`
 
    AC_ARG_WITH(
      [pmdir],
    AS_HELP_STRING(
      [--with-pmdir=DIR],
      [Install Perl modules in DIR]),
      [PMDIR=${withval}],
      [PMDIR="$pmdir_relative_path"])

    AC_SUBST([PMDIR])
    AC_MSG_RESULT([ $PMDIR ])
    # --- End perl module directory selection --------------



    
    # This is to get rid of the annoying error that occurs when
    # you use two arch flags.occur By default these commands produce a -arch for both
    # architectures. If now differentiates between OSX lion, which rejects the -fstack-protector
    # flag on the standard build environment.

    echo "This is host_os: $host_os"

    case "$host_os" in

	darwin11*|darwin12*|darwin13*|darwin14*|darwin15*) dnl This is Max OSX lion or OSX mountain lion

          if test "$OSX_UNIVERSAL" == "yes"; then

            PERL_CCOPTS=`$PERL -MExtUtils::Embed -e ccopts | perl -pe 's/\-fstack\-protector//g'`
      
            PERL_LDADD=`$PERL -MExtUtils::Embed -e ldopts | perl -pe 's/\-fstack\-protector//g'`

            # When using libtool, you can't use arch arguments.
            PERL_LDFLAGS=`$PERL -MExtUtils::Embed -e ldopts | perl -pe 's/\-arch\s\S+\s//g' | perl -pe 's/\-fstack\-protector//g'`

          else

            PERL_CCOPTS=`$PERL -MExtUtils::Embed -e ccopts | perl -pe 's/\-arch\s\S+\s//g' | perl -pe 's/\-fstack\-protector//g'`
    
            PERL_LDADD=`$PERL -MExtUtils::Embed -e ldopts | perl -pe 's/\-arch\s\S+\s//g' | perl -pe 's/\-fstack\-protector//g'`

            PERL_LDFLAGS=`$PERL -MExtUtils::Embed -e ldopts | perl -pe 's/\-arch\s\S+\s//g' | perl -pe 's/\-fstack\-protector//g'`

          fi
        ;;
	
	*) dnl all other Mac OSX versions

          if test "$OSX_UNIVERSAL" == "yes"; then

            PERL_CCOPTS=`$PERL -MExtUtils::Embed -e ccopts`
      
            PERL_LDADD=`$PERL -MExtUtils::Embed -e ldopts`

            # When using libtool, you can't use arch arguments.
            PERL_LDFLAGS=`$PERL -MExtUtils::Embed -e ldopts | perl -pe 's/\-arch\s\S+\s//g'`

          else

            PERL_CCOPTS=`$PERL -MExtUtils::Embed -e ccopts | perl -pe 's/\-arch\s\S+\s//g'`
    
            PERL_LDADD=`$PERL -MExtUtils::Embed -e ldopts | perl -pe 's/\-arch\s\S+\s//g'`

            PERL_LDFLAGS=`$PERL -MExtUtils::Embed -e ldopts | perl -pe 's/\-arch\s\S+\s//g'`

          fi
        ;;

    esac

    AC_SUBST(PERL_CCOPTS)
    AC_SUBST(PERL_LDADD)
    AC_SUBST(PERL_LDFLAGS)



    dnl OLD LINE:
    dnl AC_CHECK_PROG(SWIG, swig, [NULL, [/usr/bin/swig],[/usr/local/bin/swig /opt/local/bin/swig])
    dnl AC_SUBST(SWIG)

    AC_CHECK_PROGS(SWIG, swig, [NULL], [/usr/bin /usr/local/bin])

    dnl AC_MSG_CHECKING([Checking for swig])
    case $SWIG in
      NULL*)
        echo ""
        echo "Error, the standard version of swig for Mac OSX is not found."
        echo "Non standard versions of swig are known to cause problems."
        AC_ERROR([Swig for Mac OSX is not found.])
        ;;
dnl       *)
dnl         AC_MSG_RESULT([ yes ])
dnl         ;;
    esac


    PERLLIB_EXTENSION='dylib'
    AC_SUBST(PERLLIB_EXTENSION)

    SWIGCOMPILELINKSFORPERL='-g -Wno-declaration-after-statement -DPRE_PROTO_TRAVERSAL -I$(top_builddir) -I$(top_builddir)/hierarchy/output/symbols -fPIC -dynamic $(PERL_CCOPTS)'
    AC_SUBST(SWIGCOMPILELINKSFORPERL)

    SWIGCOMPILECOMMAND_PERL='gcc -Wno-declaration-after-statement $(SWIGCOMPILELINKSFORPERL) -c swiggable_neurospaces_wrap.c'
    AC_SUBST(SWIGCOMPILECOMMAND_PERL)


    # Mando: If building universal binaries we need different flags for libtool
    # can possibly use libtool for both builds but not going to replace
    # the working one just yet.    
    if test "$OSX_UNIVERSAL" == "yes"; then 

      SWIGLDLINKSFORPERL='-dynamic -undefined suppress -flat_namespace -L$(top_builddir) -lneurospacesread -L$(top_builddir)/algorithms/event -levent_algorithms -L$(top_builddir)/algorithms/symbol -lsymbol_algorithms $(PERL_LDFLAGS)'

    else

      SWIGLDLINKSFORPERL='-L$(top_builddir) -lneurospacesread -L$(top_builddir)/algorithms/event -levent_algorithms -L$(top_builddir)/algorithms/symbol -lsymbol_algorithms -lncurses -dylib -undefined suppress -flat_namespace $(PERL_LDFLAGS)'

    fi

    AC_SUBST(SWIGLDLINKSFORPERL)

    dnl Here we check for specific versions of mac osx since flags are different for each version
    dnl probably need to make this section neater sometime. 
    case "$host_os" in

	darwin10*)

          if test "$OSX_UNIVERSAL" == "yes"; then
  
            SWIGLINKCOMMAND_PERL='$(AR) $(SWIGLDLINKSFORPERL) -o SwiggableNeurospaces.$(PERLLIB_EXTENSION) swiggable_neurospaces_wrap.o'
          
          else

            SWIGLINKCOMMAND_PERL='ld $(SWIGLDLINKSFORPERL) -o SwiggableNeurospaces.$(PERLLIB_EXTENSION) /usr/lib/bundle1.o  swiggable_neurospaces_wrap.o'

          fi

          AC_SUBST(SWIGLINKCOMMAND_PERL)

	;;


	*)
	    dnl This probably needs to be patitioned into leopard, tiger, panther. etc

          SWIGLINKCOMMAND_PERL='ld $(SWIGLDLINKSFORPERL) -o SwiggableNeurospaces.$(PERLLIB_EXTENSION) swiggable_neurospaces_wrap.o'
            AC_SUBST(SWIGLINKCOMMAND_PERL)
	;;
    esac 


    PYTHONLIB_EXTENSION='so'
    AC_SUBST(PYTHONLIB_EXTENSION)
    
    SWIGCOMPILELINKSFORPYTHON='-g -DPRE_PROTO_TRAVERSAL $(PYTHON_INCLUDE) -I${top_builddir} -I${top_builddir}/hierarchy/output/symbols -fPIC'
    AC_SUBST(SWIGCOMPILELINKSFORPYTHON)


    SWIGCOMPILECOMMAND_PYTHON='gcc -Wno-declaration-after-statement $(SWIGCOMPILELINKSFORPYTHON) -c swiggable_neurospaces_wrap.c'
    AC_SUBST(SWIGCOMPILECOMMAND_PYTHON)


    if test "$OSX_UNIVERSAL" == "yes"; then 

      SWIGLDLINKSFORPYTHON='-dynamic -undefined suppress -flat_namespace -L$(top_builddir) -lneurospacesread -L$(top_builddir)/algorithms/event -levent_algorithms -L$(top_builddir)/algorithms/symbol -lsymbol_algorithms -lncurses $(PYTHON_LDFLAGS)'

    else

      SWIGLDLINKSFORPYTHON='$(PYTHON_LDFLAGS) -L$(top_builddir) -lneurospacesread -L$(top_builddir)/algorithms/event -levent_algorithms -L$(top_builddir)/algorithms/symbol -lsymbol_algorithms -lncurses -lreadline -flat_namespace -undefined suppress -bundle -bundle_loader $(PYTHON_EXE)'

    fi

    
    AC_SUBST(SWIGLDLINKSFORPYTHON)


    case "$host_os" in
	darwin10*)

          if test "$OSX_UNIVERSAL" == "yes"; then 

            SWIGLINKCOMMAND_PYTHON='$(AR) $(SWIGLDLINKSFORPYTHON) -o _SwiggableNeurospaces.$(PYTHONLIB_EXTENSION) swiggable_neurospaces_wrap.o'

	    MODEL_CONTAINER_SWIGLINKCOMMAND_PYTHON='$(AR) $(SWIGLDLINKSFORPYTHON) -o $(srcdir)/neurospaces/model_container/_model_container_base.so model_container_wrap.o'

          else

            SWIGLINKCOMMAND_PYTHON='ld $(SWIGLDLINKSFORPYTHON) -o _SwiggableNeurospaces.$(PYTHONLIB_EXTENSION) /usr/lib/bundle1.o swiggable_neurospaces_wrap.o'


	    MODEL_CONTAINER_SWIGLINKCOMMAND_PYTHON='ld $(SWIGLDLINKSFORPYTHON) -o $(srcdir)/neurospaces/model_container/_model_container_base.so /usr/lib/bundle1.o model_container_wrap.o'
 
          fi
            
          AC_SUBST(SWIGLINKCOMMAND_PYTHON)
          AC_SUBST(MODEL_CONTAINER_SWIGLINKCOMMAND_PYTHON)

	;;

	*)


            SWIGLINKCOMMAND_PYTHON='ld $(SWIGLDLINKSFORPYTHON) -o _SwiggableNeurospaces.$(PYTHONLIB_EXTENSION) swiggable_neurospaces_wrap.o'
            AC_SUBST(SWIGLINKCOMMAND_PYTHON)

	    MODEL_CONTAINER_SWIGLINKCOMMAND_PYTHON='ld $(SWIGLDLINKSFORPYTHON) -o $(srcdir)/neurospaces/model_container/_nmc_base.so nmc_wrap.o'
            AC_SUBST(MODEL_CONTAINER_SWIGLINKCOMMAND_PYTHON)

            
	;;
    esac 


    AC_MSG_RESULT([done setting Mac OSX settings.])
    dnl }}} end MAC OS X settings
    ;;




  *)
    dnl {{{ Default settings (Linux 2.6)
    AR='ar'
    ARFLAGS='cru'
    AC_SUBST(AR)
    AC_SUBST(ARFLAGS)
    AC_MSG_CHECKING([ranlib invocation ])
    AC_MSG_RESULT([$AR $ARFLAGS])

    dnl Check for some needed programs.
    AC_CHECK_PROGS(PERL, perl5 perl)
    AC_SUBST(PERL)

    #-- Here we determine the install path for perl modules --
    AC_MSG_CHECKING([Checking the perl module installation path])	
    pmdir_relative_path=`\
      $PERL -MConfig \
        -wle '($_ = $Config{installsitelib})
              =~ s!^\Q$Config{siteprefix}/!!; \
              print'`
 
    AC_ARG_WITH(
      [pmdir],
    AS_HELP_STRING(
      [--with-pmdir=DIR],
      [Install Perl modules in DIR]),
      [PMDIR=${withval}],
      [PMDIR='${prefix}'/"$pmdir_relative_path"])

    AC_SUBST([PMDIR])
    AC_MSG_RESULT([ $PMDIR ])
    # --- End perl module directory selection --------------

    dnl Need to have the compilation fail if swig and perl are not found at all.
    AC_CHECK_PROGS(SWIG, swig)
    AC_SUBST(SWIG)

    # determine linker flags for perl embedding

    PERL_CCOPTS=`$PERL -MExtUtils::Embed -e ccopts`
    AC_SUBST(PERL_CCOPTS)

    PERL_LDADD=`$PERL -MExtUtils::Embed -e ldopts`
    AC_SUBST(PERL_LDADD)

    PERL_LDFLAGS=`$PERL -MExtUtils::Embed -e ldopts`
    AC_SUBST(PERL_LDFLAGS)



    PERLLIB_EXTENSION='so'
    AC_SUBST(PERLLIB_EXTENSION)

    SWIGCOMPILELINKSFORPERL='-g -DPRE_PROTO_TRAVERSAL -I$(top_builddir) -I$(top_builddir)/hierarchy/output/symbols 	-I$(top_builddir)/hierarchy/output/symbols/ -fPIC $(PERL_CCOPTS)'
    AC_SUBST(SWIGCOMPILELINKSFORPERL)

    SWIGCOMPILECOMMAND_PERL='gcc -Wno-declaration-after-statement        $(SWIGCOMPILELINKSFORPERL) -c swiggable_neurospaces_wrap.c' 
    AC_SUBST(SWIGCOMPILECOMMAND_PERL)

    SWIGLDLINKSFORPERL='-g -shared swiggable_neurospaces_wrap.o 	-L$(top_builddir) -lneurospacesread -L$(top_builddir)/algorithms/event -levent_algorithms 	-L$(top_builddir)/algorithms/symbol 	-lsymbol_algorithms 	-lncurses 	-lhistory 	-lreadline'
    AC_SUBST(SWIGLDLINKSFORPERL)

    SWIGLINKCOMMAND_PERL='gcc -Wno-declaration-after-statement        $(SWIGLDLINKSFORPERL)         -o SwiggableNeurospaces.$(PERLLIB_EXTENSION)'
    AC_SUBST(SWIGCOMPILECOMMAND_PERL)





    PYTHONLIB_EXTENSION='so'
    AC_SUBST(PYTHONLIB_EXTENSION)

    SWIGCOMPILELINKSFORPYTHON='-g -Wno-declaration-after-statement -DPRE_PROTO_TRAVERSAL $(PYTHON_INCLUDE) -I${top_builddir} -I${top_builddir}/hierarchy/output/symbols -fPIC -Xlinker -export-dynamic'
    AC_SUBST(SWIGCOMPILELINKSFORPYTHON)
   
    SWIGCOMPILECOMMAND_PYTHON='gcc $(SWIGCOMPILELINKSFORPYTHON) -c swiggable_neurospaces_wrap.c'
    AC_SUBST(SWIGCOMPILECOMMAND_PYTHON)

    SWIGLDLINKSFORPYTHON='-L${top_builddir} -lneurospacesread -L${top_builddir}/algorithms/event -levent_algorithms -L${top_builddir}/algorithms/symbol 	-lsymbol_algorithms 	-lncurses 	-lhistory 	-lreadline 	-fPIC -Xlinker -export-dynamic $(PYTHON_LDFLAGS)'
    AC_SUBST(SWIGLDLINKSFORPYTHON)
  
    SWIGLINKCOMMAND_PYTHON='gcc -shared swiggable_neurospaces_wrap.o $(SWIGLDLINKSFORPYTHON)  -o _SwiggableNeurospaces.$(PYTHONLIB_EXTENSION)'
    AC_SUBST(SWIGLINKCOMMAND_PYTHON)

    # note: Must remember that the "-shared objectfile.o" part must be FIRST, otherwise it will silently
    # not link the symbols but give the appearance that it has completed successully. 
    MODEL_CONTAINER_SWIGLINKCOMMAND_PYTHON='gcc -shared model_container_wrap.o $(SWIGLDLINKSFORPYTHON) -o $(srcdir)/neurospaces/model_container/_model_container_base.so'
    AC_SUBST(MODEL_CONTAINER_SWIGLINKCOMMAND_PYTHON)

    dnl }}} End of General Settings
  
  ;;
esac
dnl }}}


AC_CONFIG_FILES([Makefile
		src/Makefile])
dnl 		 perl/Makefile
dnl 		 python/Makefile])

AC_OUTPUT

