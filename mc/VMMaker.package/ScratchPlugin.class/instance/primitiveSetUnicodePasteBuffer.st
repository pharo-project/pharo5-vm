os functions
primitiveSetUnicodePasteBuffer
	"Set the Mac OS X Unicode paste buffer."

	| utf16 strOop count |
	<export: true>
	<var: 'utf16' declareC: 'short *utf16'>

	strOop := interpreterProxy stackValue: 0.

	interpreterProxy success: (interpreterProxy isBytes: strOop).

	interpreterProxy failed ifTrue: [^ 0].

	utf16 := self cCoerce: (interpreterProxy firstIndexableField: strOop) to: #'short *'.
	count := interpreterProxy stSizeOf: strOop.

	self SetUnicodePaste: utf16 Buffer: count.

	interpreterProxy pop: 1.  "pop arg, leave rcvr on stack"
	^ 0