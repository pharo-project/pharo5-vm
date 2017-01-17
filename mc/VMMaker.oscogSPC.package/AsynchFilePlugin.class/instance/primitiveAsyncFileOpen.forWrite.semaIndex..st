primitives
primitiveAsyncFileOpen: fileName forWrite: writeFlag semaIndex: semaIndex 
	| fileNameSize fOop f okToOpen |
	<var: #f type: 'AsyncFile *'>
	self primitive: 'primitiveAsyncFileOpen' parameters: #(#String #Boolean #SmallInteger ).
	fileNameSize := interpreterProxy byteSizeOf: (fileName asOop: String).
	"If the security plugin can be loaded, use it to check for permission.
	If not, assume it's ok"
	sCOAFfn ~= 0 ifTrue:
		[okToOpen := self cCode: '((sqInt (*) (char *, sqInt, sqInt)) sCOAFfn)(fileName, fileNameSize, writeFlag)'
							inSmalltalk: [true].
		 okToOpen ifFalse:
			[^interpreterProxy primitiveFail]].
	fOop := interpreterProxy
				instantiateClass: interpreterProxy classByteArray
				indexableSize: (self sizeof: #AsyncFile).
	f := self asyncFileValueOf: fOop.
	interpreterProxy failed ifFalse:
		[self cCode: 'asyncFileOpen(f, fileName, fileNameSize, writeFlag, semaIndex)'].
	^fOop