transforms
primitiveTransposeMatrix
	| srcOop dstOop src dst |
	<export: true>
	<var: #src declareC:'float *src'>
	<var: #dst declareC:'float *dst'>

	interpreterProxy methodArgumentCount = 0
		ifFalse:[^interpreterProxy primitiveFail].
	srcOop := interpreterProxy stackObjectValue: 0.
	interpreterProxy failed ifTrue:[^nil].
	((interpreterProxy isWords: srcOop) and:[(interpreterProxy slotSizeOf: srcOop) = 16])
		ifFalse:[^interpreterProxy primitiveFail].
	dstOop := interpreterProxy clone: srcOop.
	"reload srcOop in case of GC"
	srcOop := interpreterProxy stackObjectValue: 0.
	src := interpreterProxy firstIndexableField: srcOop.
	dst := interpreterProxy firstIndexableField: dstOop.

	"dst at: 0 put: (src at: 0)."
	dst at: 1 put: (src at: 4). 
	dst at: 2 put: (src at: 8). 
	dst at: 3 put: (src at: 12).

	dst at: 4 put: (src at: 1). 
	"dst at: 5 put: (src at: 5)."
	dst at: 6 put: (src at: 9). 
	dst at: 7 put: (src at: 13).

	dst at: 8 put: (src at: 2). 
	dst at: 9 put: (src at: 6). 
	"dst at: 10 put: (src at: 10)."
	dst at: 11 put: (src at: 14).

	dst at: 12 put: (src at: 3). 
	dst at: 13 put: (src at: 7). 
	dst at: 14 put: (src at: 11). 
	"dst at: 15 put: (src at: 15)."

	interpreterProxy pop: 1.
	^interpreterProxy push: dstOop.
