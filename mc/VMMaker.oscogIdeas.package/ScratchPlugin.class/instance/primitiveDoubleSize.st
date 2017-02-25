scaling
primitiveDoubleSize

	| in out inOop outOop inW inH outW outH dstX dstY baseIndex pix i |
	<export: true>
	<var: 'in' declareC: 'int *in'>
	<var: 'out' declareC: 'int *out'>

	inOop := interpreterProxy stackValue: 7.
	inW := interpreterProxy stackIntegerValue: 6.
	inH := interpreterProxy stackIntegerValue: 5.
	outOop := interpreterProxy stackValue: 4.
	outW := interpreterProxy stackIntegerValue: 3.
	outH := interpreterProxy stackIntegerValue: 2.
	dstX := interpreterProxy stackIntegerValue: 1.
	dstY := interpreterProxy stackIntegerValue: 0.

	in := self checkedUnsignedIntPtrOf: inOop.
	out := self checkedUnsignedIntPtrOf: outOop.
	interpreterProxy success: (dstX + (2 * inW)) < outW.
	interpreterProxy success: (dstY + (2 * inH)) < outH.
	interpreterProxy failed ifTrue: [^ nil].

	0 to: inH - 1 do: [:y |
		baseIndex := ((dstY + (2 * y)) * outW) + dstX.
		0 to: inW - 1 do: [:x |
			pix := in at: x + (y * inW).
			i := baseIndex + (2 * x).
			out at: i put: pix.
			out at: i + 1 put: pix.
			out at: i + outW put: pix.
			out at: i + outW + 1 put: pix]].

	interpreterProxy pop: 8.  "pop args, leave rcvr on stack"
	^ 0
