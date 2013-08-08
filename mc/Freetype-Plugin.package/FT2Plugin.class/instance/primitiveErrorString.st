primitives-error code
primitiveErrorString
	| str ftError |
	self primitive: 'primitiveErrorString' parameters: #().
	self var: #str type: 'const char *'.
	"This magic is so that we get a static lookup table defined.
	See fterrors.h."

	self cCode: '
struct ftError { int errCode; const char* errMsg; };
#undef __FTERRORS_H__
#define FT_ERRORDEF( e, v, s )  { e, s },
#define FT_ERROR_START_LIST     {
#define FT_ERROR_END_LIST       { 0xFF, "Bad Squeak Method Parameter" }, { 0, NULL } };
static const struct ftError ftErrors[] =
#include FT_ERRORS_H
'.
	self var: #ftError type: 'const struct ftError *'.

	ftError := self cCode: 'ftErrors'.
	self touch: ftError.

	[ (str := self cCode: 'ftError->errMsg') and: [ (self cCode: 'FT_ERROR_BASE(errorCode) != ftError->errCode') ] ]
		whileTrue: [ self cCode: 'ftError++' ].
	self touch: str.

	str ifFalse: [ interpreterProxy success: false ].
	interpreterProxy failed ifTrue: [^ nil].

	interpreterProxy pop: 1 thenPush: (self ftAllocateStringForPointer: str).
