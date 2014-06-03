sound
primitiveCondenseSound

	| srcOop dstOop factor sz src dst count max v |
	<export: true>
	<var: 'src' declareC: 'short *src'>
	<var: 'dst' declareC: 'short *dst'>

	srcOop := interpreterProxy stackValue: 2.
	dstOop := interpreterProxy stackValue: 1.
	factor := interpreterProxy stackIntegerValue: 0.
	interpreterProxy success: (interpreterProxy isWords: srcOop).
	interpreterProxy success: (interpreterProxy isWords: dstOop).

	count := (2 * (interpreterProxy stSizeOf: srcOop)) // factor.
	sz := 2 * (interpreterProxy stSizeOf: dstOop).
	interpreterProxy success: (sz >= count).
	interpreterProxy failed ifTrue: [^ nil].

	src := self cCoerce: (interpreterProxy firstIndexableField: srcOop) to: 'short *'.
	dst := self cCoerce: (interpreterProxy firstIndexableField: dstOop) to: 'short *'.

	1 to: count do: [:i |
		max := 0.
		1 to: factor do: [:j |
			v := self cCode: '*src++'.
			v < 0 ifTrue: [v := 0 - v].
			v > max ifTrue: [max := v]].
		self cCode: '*dst++ = max'].

	interpreterProxy pop: 3.  "pop args, leave rcvr on stack"
	^ 0
