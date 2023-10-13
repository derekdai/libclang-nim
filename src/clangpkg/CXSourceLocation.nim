import "CXFile.nim"
import "CXString.nim"

## *
##  @}
##
## *
##  \defgroup CINDEX_LOCATIONS Physical source locations
##
##  Clang represents physical source locations in its abstract syntax tree in
##  great detail, with file, line, and column information for the majority of
##  the tokens parsed in the source code. These data types and functions are
##  used to represent source location information, either for a particular
##  point in the program or for a range of points in the program, and extract
##  specific location information from those data types.
##
##  @{
##
## *
##  Identifies a specific source location within a translation
##  unit.
##
##  Use clang_getExpansionLocation() or clang_getSpellingLocation()
##  to map a source location to a particular file, line, and column.
##

type
  CXSourceLocation* {.bycopy.} = object
    ptr_data*: array[2, pointer]
    int_data*: cuint


## *
##  Identifies a half-open character range in the source code.
##
##  Use clang_getRangeStart() and clang_getRangeEnd() to retrieve the
##  starting and end locations from a source range, respectively.
##

type
  CXSourceRange* {.bycopy.} = object
    ptr_data*: array[2, pointer]
    begin_int_data*: cuint
    end_int_data*: cuint


## *
##  Retrieve a NULL (invalid) source location.
##

proc getNullLocation*(): CXSourceLocation {.importc: "clang_getNullLocation",
    cdecl.}
## *
##  Determine whether two source locations, which must refer into
##  the same translation unit, refer to exactly the same point in the source
##  code.
##
##  \returns non-zero if the source locations refer to the same location, zero
##  if they refer to different locations.
##

proc equalLocations*(loc1: CXSourceLocation; loc2: CXSourceLocation): cuint {.
    importc: "clang_equalLocations", cdecl.}
## *
##  Returns non-zero if the given source location is in a system header.
##

proc Location_isInSystemHeader*(location: CXSourceLocation): cint {.
    importc: "clang_Location_isInSystemHeader", cdecl.}
## *
##  Returns non-zero if the given source location is in the main file of
##  the corresponding translation unit.
##

proc Location_isFromMainFile*(location: CXSourceLocation): cint {.
    importc: "clang_Location_isFromMainFile", cdecl.}
## *
##  Retrieve a NULL (invalid) source range.
##

proc getNullRange*(): CXSourceRange {.importc: "clang_getNullRange", cdecl.}
## *
##  Retrieve a source range given the beginning and ending source
##  locations.
##

proc getRange*(begin: CXSourceLocation; `end`: CXSourceLocation): CXSourceRange {.
    importc: "clang_getRange", cdecl.}
## *
##  Determine whether two ranges are equivalent.
##
##  \returns non-zero if the ranges are the same, zero if they differ.
##

proc equalRanges*(range1: CXSourceRange; range2: CXSourceRange): cuint {.
    importc: "clang_equalRanges", cdecl.}
## *
##  Returns non-zero if \p range is null.
##

proc isNull*(range: CXSourceRange): cint {.importc: "clang_Range_isNull",
    cdecl.}
## *
##  Retrieve the file, line, column, and offset represented by
##  the given source location.
##
##  If the location refers into a macro expansion, retrieves the
##  location of the macro expansion.
##
##  \param location the location within a source file that will be decomposed
##  into its parts.
##
##  \param file [out] if non-NULL, will be set to the file to which the given
##  source location points.
##
##  \param line [out] if non-NULL, will be set to the line to which the given
##  source location points.
##
##  \param column [out] if non-NULL, will be set to the column to which the given
##  source location points.
##
##  \param offset [out] if non-NULL, will be set to the offset into the
##  buffer to which the given source location points.
##

proc getExpansionLocation*(location: CXSourceLocation; file: ptr CXFile;
                          line: ptr cuint; column: ptr cuint; offset: ptr cuint) {.
    importc: "clang_getExpansionLocation", cdecl.}
## *
##  Retrieve the file, line and column represented by the given source
##  location, as specified in a # line directive.
##
##  Example: given the following source code in a file somefile.c
##
##  \code
##  #123 "dummy.c" 1
##
##  static int func(void)
##  {
##      return 0;
##  }
##  \endcode
##
##  the location information returned by this function would be
##
##  File: dummy.c Line: 124 Column: 12
##
##  whereas clang_getExpansionLocation would have returned
##
##  File: somefile.c Line: 3 Column: 12
##
##  \param location the location within a source file that will be decomposed
##  into its parts.
##
##  \param filename [out] if non-NULL, will be set to the filename of the
##  source location. Note that filenames returned will be for "virtual" files,
##  which don't necessarily exist on the machine running clang - e.g. when
##  parsing preprocessed output obtained from a different environment. If
##  a non-NULL value is passed in, remember to dispose of the returned value
##  using \c clang_disposeString() once you've finished with it. For an invalid
##  source location, an empty string is returned.
##
##  \param line [out] if non-NULL, will be set to the line number of the
##  source location. For an invalid source location, zero is returned.
##
##  \param column [out] if non-NULL, will be set to the column number of the
##  source location. For an invalid source location, zero is returned.
##

proc getPresumedLocation*(location: CXSourceLocation; filename: ptr CXString;
                         line: ptr cuint; column: ptr cuint) {.
    importc: "clang_getPresumedLocation", cdecl.}
## *
##  Legacy API to retrieve the file, line, column, and offset represented
##  by the given source location.
##
##  This interface has been replaced by the newer interface
##  #clang_getExpansionLocation(). See that interface's documentation for
##  details.
##

proc getInstantiationLocation*(location: CXSourceLocation; file: ptr CXFile;
                              line: ptr cuint; column: ptr cuint; offset: ptr cuint) {.
    importc: "clang_getInstantiationLocation", cdecl.}
## *
##  Retrieve the file, line, column, and offset represented by
##  the given source location.
##
##  If the location refers into a macro instantiation, return where the
##  location was originally spelled in the source file.
##
##  \param location the location within a source file that will be decomposed
##  into its parts.
##
##  \param file [out] if non-NULL, will be set to the file to which the given
##  source location points.
##
##  \param line [out] if non-NULL, will be set to the line to which the given
##  source location points.
##
##  \param column [out] if non-NULL, will be set to the column to which the given
##  source location points.
##
##  \param offset [out] if non-NULL, will be set to the offset into the
##  buffer to which the given source location points.
##

proc getSpellingLocation*(location: CXSourceLocation; file: ptr CXFile;
                         line: ptr cuint; column: ptr cuint; offset: ptr cuint) {.
    importc: "clang_getSpellingLocation", cdecl.}
## *
##  Retrieve the file, line, column, and offset represented by
##  the given source location.
##
##  If the location refers into a macro expansion, return where the macro was
##  expanded or where the macro argument was written, if the location points at
##  a macro argument.
##
##  \param location the location within a source file that will be decomposed
##  into its parts.
##
##  \param file [out] if non-NULL, will be set to the file to which the given
##  source location points.
##
##  \param line [out] if non-NULL, will be set to the line to which the given
##  source location points.
##
##  \param column [out] if non-NULL, will be set to the column to which the given
##  source location points.
##
##  \param offset [out] if non-NULL, will be set to the offset into the
##  buffer to which the given source location points.
##

proc getFileLocation*(location: CXSourceLocation; file: ptr CXFile; line: ptr cuint;
                     column: ptr cuint; offset: ptr cuint) {.
    importc: "clang_getFileLocation", cdecl.}
## *
##  Retrieve a source location representing the first character within a
##  source range.
##

proc getRangeStart*(range: CXSourceRange): CXSourceLocation {.
    importc: "clang_getRangeStart", cdecl.}
## *
##  Retrieve a source location representing the last character within a
##  source range.
##

proc getRangeEnd*(range: CXSourceRange): CXSourceLocation {.
    importc: "clang_getRangeEnd", cdecl.}
## *
##  Identifies an array of ranges.
##

type
  CXSourceRangeList* {.bycopy.} = object
    count*: cuint              ## * The number of ranges in the \c ranges array.
    ## *
    ##  An array of \c CXSourceRanges.
    ##
    ranges*: ptr CXSourceRange

## *
##  Destroy the given \c CXSourceRangeList.
##

proc dispose*(ranges: ptr CXSourceRangeList) {.
    importc: "clang_disposeSourceRangeList", cdecl.}
