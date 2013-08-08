primitives - OS process access
primitiveGetCurrentWorkingDirectory
	"Answer a string containing the current working directory."

	| buffer charSize cwdString requiredLen cwdLen |
	<export: true>
	<var: 'buffer' type: #'char *'>
	<var: 'requiredLen' type: #DWORD>
	<var: 'cwdLen' type: #DWORD>

	charSize := self sizeof: #TCHAR asSymbol.

	"Determine required size of result buffer (this form counts the terminating null)"
	requiredLen := self cCode: 'GetCurrentDirectory(0, 0)' inSmalltalk: [0].
	requiredLen = 0 ifTrue: [^ interpreterProxy primitiveFail].

	"Allocate a buffer with room for the terminating null"
	buffer := self alloca: requiredLen * charSize.
	"Call GetCurrentDirectory() again to get the actual result (which does not count the terminating null (!!))"
	cwdLen := self cCode: 'GetCurrentDirectory(requiredLen, buffer)' inSmalltalk: [requiredLen - 1].
	(cwdLen = 0 or: [cwdLen > requiredLen]) ifTrue: [^ interpreterProxy primitiveFail].

	"Allocate the real buffer"
	cwdString := interpreterProxy
					instantiateClass: interpreterProxy classString
					indexableSize: cwdLen * charSize.
	
	self st: (interpreterProxy arrayValueOf: cwdString) rn: buffer cpy: cwdLen * charSize.

	interpreterProxy pop: 1 thenPush: cwdString
 