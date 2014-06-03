scaling
primitiveHalfSizeDiagonal

	| in inW inH out outW outH srcX srcY dstX dstY dstW dstH srcIndex dstIndex p1 p2 r g b |
	<export: true>
	<var: 'in' declareC: 'int *in'>
	<var: 'out' declareC: 'int *out'>

	in := self checkedUnsignedIntPtrOf: (interpreterProxy stackValue: 11).
	inW := interpreterProxy stackIntegerValue: 10.
	inH := interpreterProxy stackIntegerValue: 9.
	out := self checkedUnsignedIntPtrOf: (interpreterProxy stackValue: 8).
	outW := interpreterProxy stackIntegerValue: 7.
	outH := interpreterProxy stackIntegerValue: 6.
	srcX := interpreterProxy stackIntegerValue: 5.
	srcY := interpreterProxy stackIntegerValue: 4.
	dstX := interpreterProxy stackIntegerValue: 3.
	dstY := interpreterProxy stackIntegerValue: 2.
	dstW := interpreterProxy stackIntegerValue: 1.
	dstH := interpreterProxy stackIntegerValue: 0.

	interpreterProxy success: (srcX >= 0) & (srcY >= 0).
	interpreterProxy success: (srcX + (2 * dstW)) <= inW.
	interpreterProxy success: (srcY + (2 * dstH)) <= inH.
	interpreterProxy success: (dstX >= 0) & (dstY >= 0).
	interpreterProxy success: (dstX + dstW) <= outW.
	interpreterProxy success: (dstY + dstH) <= outH.
	interpreterProxy failed ifTrue: [^ nil].

	0 to: dstH - 1 do: [:y |
		srcIndex := (inW * (srcY + (2 * y))) + srcX.
		dstIndex := (outW * (dstY + y)) + dstX.
		0 to: dstW - 1 do: [:x |
			p1 := in at: srcIndex.
			p2 := in at: srcIndex + inW + 1.

			r := (((p1 bitAnd: 16rFF0000) + (p2 bitAnd: 16rFF0000)) bitShift: -1) bitAnd: 16rFF0000.
			g := (((p1 bitAnd: 16rFF00) + (p2 bitAnd: 16rFF00)) bitShift: -1) bitAnd: 16rFF00.
			b := ((p1 bitAnd: 16rFF) + (p2 bitAnd: 16rFF)) bitShift: -1.

			"store combined RGB into target bitmap"
			out at: dstIndex put: (r bitOr: (g bitOr: b)).

			srcIndex := srcIndex + 2.
			dstIndex := dstIndex + 1]].

	interpreterProxy pop: 12.  "pop args, leave rcvr on stack"
	^ 0
