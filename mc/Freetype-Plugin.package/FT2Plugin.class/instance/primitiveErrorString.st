primitives-error code
primitiveErrorString
	| str ftError |
	
	<var: #str type: 'const char *'>
	<var: #ftError declareC: 'FT2Error *ftError'>
	
	self primitive: 'primitiveErrorString' parameters: #().
	
	"This magic is so that we get a static lookup table defined.
	See fterrors.h."

	self cCode: '
#undef __FTERRORS_H__
#define FT_ERRORDEF( e, v, s )  { e, s },
#define FT_ERROR_START_LIST     {
#define FT_ERROR_END_LIST       { 0xFF, "Bad Squeak Method Parameter" }, { 0, NULL } };
static const FT2Error ftErrors[] =
#include FT_ERRORS_H
'.
	ftError := self cCode: 'ftErrors'.
	self touch: ftError.

	[ (str := self cCode: 'ftError->errMsg') and: [ (self cCode: 'FT_ERROR_BASE(errorCode) != ftError->errCode') ] ]
		whileTrue: [ self cCode: 'ftError++' ].
	self touch: str.

	str ifFalse: [ interpreterProxy success: false ].
	interpreterProxy failed ifTrue: [^ nil].

	interpreterProxy pop: 1 thenPush: (self ftAllocateStringForPointer: str).
