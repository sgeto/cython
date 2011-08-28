# mode: run
# ticket: 568

cimport cython

cdef class FinalMethods(object):
    """
    >>> obj = FinalMethods()
    >>> obj.test_cdef()
    >>> obj.test_cpdef()
    """

    @cython.test_assert_path_exists("//CFuncDefNode[@entry.is_final_cmethod=True]")
    @cython.final
    cdef cdef_method(self):
        pass

    @cython.test_assert_path_exists("//CFuncDefNode[@entry.is_final_cmethod=True]")
    @cython.test_fail_if_path_exists("//CFuncDefNode//OverrideCheckNode")
    @cython.final
    cpdef cpdef_method(self):
        pass

    @cython.test_assert_path_exists("//AttributeNode[@entry.is_final_cmethod=True]")
    def test_cdef(self):
        self.cdef_method()

    @cython.test_assert_path_exists("//AttributeNode[@entry.is_final_cmethod=True]")
    def test_cpdef(self):
        self.cpdef_method()


cdef class SubType(FinalMethods):
    """
    >>> obj = SubType()
    >>> obj.test_cdef()
    >>> obj.test_cpdef()
    """
    @cython.test_assert_path_exists("//AttributeNode[@entry.is_final_cmethod=True]")
    def test_cdef(self):
        self.cdef_method()

    @cython.test_assert_path_exists("//AttributeNode[@entry.is_final_cmethod=True]")
    def test_cpdef(self):
        self.cpdef_method()
