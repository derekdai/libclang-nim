import std/time_t
export time_t

import "CXString.nim"

type
  CXFile* = distinct pointer

## *
##  Retrieve the complete file and path name of the given file.
##

proc getFileName*(SFile: CXFile): CXString {.importc: "clang_getFileName",
    cdecl.}
## *
##  Retrieve the last modification time of the given file.
##

proc getFileTime*(SFile: CXFile): Time {.importc: "clang_getFile`",
                                       cdecl.}
## *
##  Uniquely identifies a CXFile, that refers to the same underlying file,
##  across an indexing session.
##

type
  CXFileUniqueID* {.bycopy.} = object
    data*: array[3, culonglong]


## *
##  Retrieve the unique ID for the given \c file.
##
##  \param file the file to get the ID for.
##  \param outID stores the returned CXFileUniqueID.
##  \returns If there was a failure getting the unique ID, returns non-zero,
##  otherwise returns 0.
##

proc getFileUniqueID*(file: CXFile; outID: ptr CXFileUniqueID): cint {.
    importc: "clang_getFileUniqueID", cdecl.}
## *
##  Determine whether the given header is guarded against
##  multiple inclusions, either with the conventional
##  \#ifndef/\#define/\#endif macro guards or with \#pragma once.
##

proc isEqual*(file1: CXFile; file2: CXFile): cint {.
    importc: "clang_File_isEqual", cdecl.}
## *
##  Returns the real path name of \c file.
##
##  An empty string may be returned. Use \c clang_getFileName() in that case.
##

proc tryGetRealPathName*(file: CXFile): CXString {.
    importc: "clang_File_tryGetRealPathName", cdecl.}
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

