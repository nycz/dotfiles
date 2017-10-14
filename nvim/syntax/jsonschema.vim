" Vim syntax file
" Language:	JSON Schema
" Maintainer:	nycz
" Last Change:	2016 june 1
" Version:      0.1

if !exists("main_syntax")
  " quit when a syntax file was already loaded
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'jsonschema'
endif

syntax match   jsonSchemaNoise           /\%(:\|,\)/

" NOTE that for the concealing to work your conceallevel should be set to 2

" Syntax: Strings
" Separated into a match and region because a region by itself is always greedy
syn match  jsonSchemaStringMatch /"\([^"]\|\\\"\)\+"\ze[[:blank:]\r\n]*[,}\]]/ contains=jsonSchemaString
if has('conceal')
	syn region  jsonSchemaString oneline matchgroup=jsonSchemaQuote start=/"/  skip=/\\\\\|\\"/  end=/"/ concealends contains=jsonSchemaEscape contained
else
	syn region  jsonSchemaString oneline matchgroup=jsonSchemaQuote start=/"/  skip=/\\\\\|\\"/  end=/"/ contains=jsonSchemaEscape contained
endif

" Syntax: JSON does not allow strings with single quotes, unlike JavaScript.
syn region  jsonSchemaStringSQError oneline  start=+'+  skip=+\\\\\|\\"+  end=+'+

" Syntax: JSON Keywords
" Separated into a match and region because a region by itself is always greedy
syn match  jsonSchemaKeywordMatch /"\([^"]\|\\\"\)\+"[[:blank:]\r\n]*\:/ contains=jsonSchemaKeyword
if has('conceal')
   syn region  jsonSchemaKeyword matchgroup=jsonSchemaQuote start=/"/  end=/"\ze[[:blank:]\r\n]*\:/ concealends contained
else
   syn region  jsonSchemaKeyword matchgroup=jsonSchemaQuote start=/"/  end=/"\ze[[:blank:]\r\n]*\:/ contained
endif

" Syntax: Escape sequences
syn match   jsonSchemaEscape    "\\["\\/bfnrt]" contained
syn match   jsonSchemaEscape    "\\u\x\{4}" contained

" Syntax: Numbers
syn match   jsonSchemaNumber    "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>\ze[[:blank:]\r\n]*[,}\]]"

" ERROR WARNINGS **********************************************
if (!exists("g:vim_json_warnings") || g:vim_json_warnings==1)
	" Syntax: Strings should always be enclosed with quotes.
	syn match   jsonSchemaNoQuotesError  "\<[[:alpha:]][[:alnum:]]*\>"
	syn match   jsonSchemaTripleQuotesError  /"""/

	" Syntax: An integer part of 0 followed by other digits is not allowed.
	syn match   jsonSchemaNumError  "-\=\<0\d\.\d*\>"

	" Syntax: Decimals smaller than one should begin with 0 (so .1 should be 0.1).
	syn match   jsonSchemaNumError  "\:\@<=[[:blank:]\r\n]*\zs\.\d\+"

	" Syntax: No comments in JSON, see http://stackoverflow.com/questions/244777/can-i-comment-a-json-file
	syn match   jsonSchemaCommentError  "//.*"
	syn match   jsonSchemaCommentError  "\(/\*\)\|\(\*/\)"

	" Syntax: No semicolons in JSON
	syn match   jsonSchemaSemicolonError  ";"

	" Syntax: No trailing comma after the last element of arrays or objects
	syn match   jsonSchemaTrailingCommaError  ",\_s*[}\]]"

	" Syntax: Watch out for missing commas between elements
	syn match   jsonSchemaMissingCommaError /\("\|\]\|\d\)\zs\_s\+\ze"/
	syn match   jsonSchemaMissingCommaError /\(\]\|\}\)\_s\+\ze"/ "arrays/objects as values
	syn match   jsonSchemaMissingCommaError /}\_s\+\ze{/ "objects as elements in an array
	syn match   jsonSchemaMissingCommaError /\(true\|false\)\_s\+\ze"/ "true/false as value
endif

" ********************************************** END OF ERROR WARNINGS
" Allowances for JSONP: function call at the beginning of the file,
" parenthesis and semicolon at the end.
" Function name validation based on
" http://stackoverflow.com/questions/2008279/validate-a-javascript-function-name/2008444#2008444
syn match  jsonSchemaPadding "\%^[[:blank:]\r\n]*[_$[:alpha:]][_$[:alnum:]]*[[:blank:]\r\n]*("
syn match  jsonSchemaPadding ");[[:blank:]\r\n]*\%$"

" Syntax: Boolean
syn match  jsonSchemaBoolean /\(true\|false\)\(\_s\+\ze"\)\@!/

" Syntax: Null
syn keyword  jsonSchemaNull      null

" Syntax: Braces
syn region  jsonSchemaFold matchgroup=jsonSchemaBraces start="{" end=/}\(\_s\+\ze\("\|{\)\)\@!/ transparent fold
syn region  jsonSchemaFold matchgroup=jsonSchemaBraces start="\[" end=/]\(\_s\+\ze"\)\@!/ transparent fold



" ********************** JSON SCHEMA SPECIFIC  ******************
" Syntax: Attributes
syn match  jsonSchemaAttributeMatch /"\($ref\|$schema\|definitions\|type\|enum\
                                        \|anyOf\|oneOf\|allOf\|not\
                                        \|title\|description\|default\
                                        \|format\|\(min\|max\)Length\|pattern\
                                        \|multipleOf\|\(exclusiveM\|m\)\(in\|ax\)imum\
                                        \|\(minP\|maxP\|additionalP\|patternP\|p\)roperties\
                                        \|required\|dependencies\
                                        \|\(additionalI\|uniqueI\|minI\|maxI\|i\)tems\
                                        \)":/ contains=jsonSchemaAttribute
if has('conceal')
	syn region  jsonSchemaAttribute oneline matchgroup=jsonSchemaQuote start=/"/  skip=/\\\\\|\\"/  end=/"/ concealends contains=jsonSchemaEscape contained
else
	syn region  jsonSchemaAttribute oneline matchgroup=jsonSchemaQuote start=/"/  skip=/\\\\\|\\"/  end=/"/ contains=jsonSchemaEscape contained
endif

" Syntax: Schema types
syn match  jsonSchemaTypeMatch /"\(object\|string\|array\|boolean\|number\|integer\|null\)"/ contains=jsonSchemaType
if has('conceal')
	syn region  jsonSchemaType oneline matchgroup=jsonSchemaQuote start=/"/  skip=/\\\\\|\\"/  end=/"/ concealends contains=jsonSchemaEscape contained
else
	syn region  jsonSchemaType oneline matchgroup=jsonSchemaQuote start=/"/  skip=/\\\\\|\\"/  end=/"/ contains=jsonSchemaEscape contained
endif




" Define the default highlighting.
" Only when an item doesn't have highlighting yet
hi def link jsonSchemaPadding         Operator
hi def link jsonSchemaString          String
hi def link jsonSchemaTest          Label
hi def link jsonSchemaEscape          Special
hi def link jsonSchemaNumber          Number
hi def link jsonSchemaBraces          Delimiter
hi def link jsonSchemaNull            Function
hi def link jsonSchemaBoolean         Boolean
hi def link jsonSchemaKeyword         Label
hi def link jsonSchemaAttribute       Identifier
hi def link jsonSchemaType            Type

if (!exists("g:vim_json_warnings") || g:vim_json_warnings==1)
hi def link jsonSchemaNumError        Error
hi def link jsonSchemaCommentError    Error
hi def link jsonSchemaSemicolonError  Error
hi def link jsonSchemaTrailingCommaError     Error
hi def link jsonSchemaMissingCommaError      Error
hi def link jsonSchemaStringSQError        	Error
hi def link jsonSchemaNoQuotesError        	Error
hi def link jsonSchemaTripleQuotesError     	Error
endif
hi def link jsonSchemaQuote           Quote
hi def link jsonSchemaNoise           Noise

let b:current_syntax = "json"
if main_syntax == 'json'
  unlet main_syntax
endif

" Vim settings
" vim: ts=8 fdm=marker

" MIT License
" Copyright (c) 2013, Jeroen Ruigrok van der Werven, Eli Parra
"Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the Software), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
"The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
"THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"See https://twitter.com/elzr/status/294964017926119424
