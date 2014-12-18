scaling
primitiveScale
	"Scale using bilinear interpolation."
	"This version isn't really able to do much with full ARGB based images; the A channel will be ignored and only fully transparent pixels will be treated as transparent. The output pixel will be either fully transparent or fully opaque."

	| inOop inW inH outOop outW outH in out inX inY xIncr yIncr outPix w1 w2 w3 w4 t p1 p2 p3 p4 tWeight |
	<export: true>
	<var: 'in' declareC: 'int *in'>
	<var: 'out' declareC: 'int *out'>

	inOop := interpreterProxy stackValue: 5.
	inW := interpreterProxy stackIntegerValue: 4.
	inH := interpreterProxy stackIntegerValue: 3.
	outOop := interpreterProxy stackValue: 2.
	outW := interpreterProxy stackIntegerValue: 1.
	outH := interpreterProxy stackIntegerValue: 0.

	interpreterProxy success: (interpreterProxy stSizeOf: inOop) = (inW * inH).
	interpreterProxy success: (interpreterProxy stSizeOf: outOop) = (outW * outH).
	in := self checkedUnsignedIntPtrOf: inOop.
	out := self checkedUnsignedIntPtrOf: outOop.
	interpreterProxy failed ifTrue: [^ nil].

	inX := inY := 0.					"source x and y, scaled by 1024"
	xIncr := (inW * 1024) // outW.	"source x increment, scaled by 1024"
	yIncr := (inH * 1024) // outH.		"source y increment, scaled by 1024"

	0 to: (outH - 1) do: [:outY |
		inX := 0.
		0 to: (outW - 1) do: [:outX |
			"compute weights, scaled by 2^20"
			w1 := (1024 - (inX bitAnd: 1023))	* (1024 - (inY bitAnd: 1023)).
			w2 := (inX bitAnd: 1023)			* (1024 - (inY bitAnd: 1023)).
			w3 := (1024 - (inX bitAnd: 1023))	* (inY bitAnd: 1023).
			w4 := (inX bitAnd: 1023)			* (inY bitAnd: 1023).

			"get source pixels"
			t := ((inY >> 10) * inW) + (inX >> 10).
			p1 := in at: t.
			((inX >> 10) < (inW - 1)) ifTrue: [p2 := in at: t + 1] ifFalse: [p2 := p1].
			(inY >> 10) < (inH - 1) ifTrue: [t := t + inW].  "next row"
			p3 := in at: t.
			((inX >> 10) < (inW - 1)) ifTrue: [p4 := in at: t + 1] ifFalse: [p4 := p3].

			"deal with transparent pixels"
			"Note as above - only transparent not translucent"
			tWeight := 0.
			p1 = 0 ifTrue: [p1 := p2. tWeight := tWeight + w1].
			p2 = 0 ifTrue: [p2 := p1. tWeight := tWeight + w2].
			p3 = 0 ifTrue: [p3 := p4. tWeight := tWeight + w3].
			p4 = 0 ifTrue: [p4 := p3. tWeight := tWeight + w4].
			p1 = 0 ifTrue: [p1 := p3. p2 := p4].  "both top pixels were transparent; use bottom row"
			p3 = 0 ifTrue: [p3 := p1. p4 := p2].  "both bottom pixels were transparent; use top row"

			outPix := 0.
			tWeight < 500000 ifTrue: [  "compute an (opaque) output pixel if less than 50% transparent"
				t := (w1 * ((p1 >> 16) bitAnd: 255)) + (w2 * ((p2 >> 16) bitAnd: 255)) + (w3 * ((p3 >> 16) bitAnd: 255)) + (w4 * ((p4 >> 16) bitAnd: 255)).
				outPix := ((t >> 20) bitAnd: 255) << 16.
				t := (w1 * ((p1 >> 8) bitAnd: 255)) + (w2 * ((p2 >> 8) bitAnd: 255)) + (w3 * ((p3 >> 8) bitAnd: 255)) + (w4 * ((p4 >> 8) bitAnd: 255)).
				outPix := outPix bitOr: (((t >> 20) bitAnd: 255) << 8).
				t := (w1 * (p1 bitAnd: 255)) + (w2 * (p2 bitAnd: 255)) + (w3 * (p3 bitAnd: 255)) + (w4 * (p4 bitAnd: 255)).
				outPix := outPix bitOr: ((t >> 20) bitAnd: 255).
				"If the result is black, remember to make it Squeak-standard-fake-black"
				outPix = 0 ifTrue: [outPix := 1].
				"add the A channel to make it really opaque"
				outPix := outPix bitOr: 16rFF000000].

			out at: (outY * outW) + outX put: outPix.
			inX := inX + xIncr].
		inY := inY + yIncr].

	interpreterProxy pop: 6.  "pop args, leave rcvr on stack"
	^ 0
