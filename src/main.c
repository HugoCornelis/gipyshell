
#include <Python.h>

#include <stdio.h>


int header(void);

int main(int argc, char *argv[])
{
    header();

    Py_SetProgramName(argv[0]);  /* optional but recommended */

    Py_Initialize();

    PyRun_SimpleString
	("from time import time,ctime\n"
	 "print 'Started at: ',ctime(time())\n");

    PyObject *pymodMain = PyImport_AddModule("__main__");

    Py_INCREF(pymodMain);

    PyObject *pydMain = PyModule_GetDict(pymodMain);

    Py_INCREF(pydMain);

    PyRun_String("a = (1, 2, 3)", Py_single_input, pydMain, pydMain);

    PyRun_String("a", Py_single_input, pydMain, pydMain);

    PyRun_InteractiveLoop(stdin, "stdin");

    Py_Finalize();

    return 0;
}


