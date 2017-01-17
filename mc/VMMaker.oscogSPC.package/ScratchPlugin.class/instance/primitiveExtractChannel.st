sound
primitiveExtractChannel

	| srcOop dstOop rightFlag sz src dst |
	<export: true>
	<var: 'src' declareC: 'short *src'>
	<var: 'dst' declareC: 'short *dst'>

	srcOop := interpreterProxy stackValue: 2.
	dstOop := interpreterProxy stackValue: 1.
	rightFlag := interpreterProxy booleanValueOf: (interpreterProxy stackValue: 0).
	interpreterProxy success: (interpreterProxy isWords: srcOop).
	interpreterProxy success: (interpreterProxy isWords: dstOop).

	sz := interpreterProxy stSizeOf: srcOop.
	interpreterProxy success: ((interpreterProxy stSizeOf: dstOop) >= (sz // 2)).
	interpreterProxy failed ifTrue: [^ nil].

	src := self cCoerce: (interpreterProxy firstIndexableField: srcOop) to: 'short *'.
	dst := self cCoerce: (interpreterProxy firstIndexableField: dstOop) to: 'short *'.

	rightFlag ifTrue: [self cCode: 'src++']. 
	1 to: sz do: [:i | self cCode: '*dst++ = *src; src += 2'].

	interpreterProxy pop: 3.  "pop args, leave rcvr on stack"
	^ 0
