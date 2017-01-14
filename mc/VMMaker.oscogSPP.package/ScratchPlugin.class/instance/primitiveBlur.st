other filters
primitiveBlur

	| inOop outOop width in out sz height n rTotal gTotal bTotal pix outPix |
	<export: true>
	<var: 'in' declareC: 'unsigned int *in'>
	<var: 'out' declareC: 'unsigned int *out'>

	inOop := interpreterProxy stackValue: 2.
	outOop := interpreterProxy stackValue: 1.
	width := interpreterProxy stackIntegerValue: 0.
	in := self checkedUnsignedIntPtrOf: inOop.
	out := self checkedUnsignedIntPtrOf: outOop.
	sz := interpreterProxy stSizeOf: inOop.
	interpreterProxy success: ((interpreterProxy stSizeOf: outOop) = sz).
	interpreterProxy failed ifTrue: [^ nil].

	height := sz // width.
	1 to: height - 2 do: [:y |
		1 to: width - 2 do: [:x |
			n := rTotal := gTotal := bTotal := 0.
			-1 to: 1 do: [:dY |
				-1 to: 1 do: [:dX |
					pix := (in at: ((y + dY) * width) + (x + dX) "add 1 when testing in Squeak") bitAnd: 16rFFFFFF.
					pix = 0 ifFalse: [  "skip transparent pixels"
						rTotal := rTotal + ((pix bitShift: -16) bitAnd: 16rFF).
						gTotal := gTotal + ((pix bitShift: -8) bitAnd: 16rFF).
						bTotal := bTotal + (pix bitAnd: 16rFF).
						n := n + 1]]].
			n = 0
				ifTrue: [outPix :=  0]
				ifFalse: [outPix := ((rTotal // n) bitShift: 16) + ((gTotal // n) bitShift: 8) +  (bTotal // n)].
			out at: ((y * width) + x "add 1 when testing in Squeak") put: outPix]].

	interpreterProxy pop: 3.  "pop args, leave rcvr on stack"
	^ 0
