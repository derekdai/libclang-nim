## /*===-- clang-c/Rewrite.h - C CXRewriter   --------------------------*- C
## -*-===*\
## |*                                                                            *|
## |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
## |* Exceptions.                                                                *|
## |* See https://llvm.org/LICENSE.txt for license information.                  *|
## |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*/

#ifndef LLVM_CLANG_C_REWRITE_H
#define LLVM_CLANG_C_REWRITE_H

import "CXString.nim"
import "Index.nim"

## LLVM_CLANG_C_EXTERN_C_BEGIN

typedef
  CXRewriter* = distinct pointer

## *
##  Create CXRewriter.
##
proc createCXRewriter*(U: CXTranslationUnit): CXRewriter {.importc: "clang_CXRewriter_create", cdecl.}

## *
##  Insert the specified string at the specified location in the original buffer.
##
proc insertTextBefore*(rew: CXRewriter,
                                  loc: CXSourceLocation,
                                  insert: cstring) {.importc: "clang_CXRewriter_insertTextBefore", cdecl.}

## *
##  Replace the specified range of characters in the input with the specified
##  replacement.
##
proc replaceText*(rew: CXRewriter,
                             toBeReplaced: CXSourceRange,
                             replacement: cstring) {.importc: "clang_CXRewriter_replaceText", cdecl.}

## *
##  Remove the specified range.
##
proc removeText*(rew: CXRewriter,
                            toBeRemoved: CXSourceRange) {.importc: "clang_CXRewriter_removeText", cdecl.}

## *
##  Save all changed files to disk.
##  Returns 1 if any files were not saved successfully, returns 0 otherwise.
##
proc overwriteChangedFiles*(rew: CXRewriter): cint {.importc: "clang_CXRewriter_overwriteChangedFiles", cdecl.}

## *
##  Write out rewritten version of the main file to stdout.
##
proc writeMainFileToStdOut*(rew: CXRewriter) {.importc: "clang_CXRewriter_writeMainFileToStdOut", cdecl.}

## *
##  Free the given CXRewriter.
##
proc dispose*(rew: CXRewriter) {.importc: "clang_CXRewriter_dispose", cdecl.}

## LLVM_CLANG_C_EXTERN_C_END
