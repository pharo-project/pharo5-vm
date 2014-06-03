hsv filters
primitiveBrightnessShift

	| inOop outOop shift in sz out pix r g b max min hue saturation brightness |
	<export: true>
	<var: 'in' declareC: 'unsigned int *in'>
	<var: 'out' declareC: 'unsigned int *out'>

	inOop := interpreterProxy stackValue: 2.
	outOop := interpreterProxy stackValue: 1.
	shift := interpreterProxy stackIntegerValue: 0.
	in := self checkedUnsignedIntPtrOf: inOop.
	sz := interpreterProxy stSizeOf: inOop.
	out := self checkedUnsignedIntPtrOf: outOop.
	interpreterProxy success: ((interpreterProxy stSizeOf: outOop) = sz).
	interpreterProxy failed ifTrue: [^ nil].

	0 to: sz - 1 do: [:i |
		pix := (in at: i) bitAnd: 16rFFFFFF.
		pix = 0 ifFalse: [  "skip pixel values of 0 (transparent)"
			r := (pix bitShift: -16) bitAnd: 16rFF.
			g := (pix bitShift: -8) bitAnd: 16rFF.
			b := pix bitAnd: 16rFF.

			"find min and max color components"
			max := min := r.
			g > max ifTrue: [max := g].
			b > max ifTrue: [max := b].
			g < min ifTrue: [min := g].
			b < min ifTrue: [min := b].

			"find current hue with range 0 to 360"
			hue := self hueFromR: r G: g B: b min: min max: max.

			"find current saturation and brightness with range 0 to 1000"
			max = 0 ifTrue: [saturation := 0] ifFalse: [saturation := ((max - min) * 1000) // max].
			brightness := (max * 1000) // 255.

			"compute new brigthness"
			brightness := brightness + (shift * 10).
			brightness > 1000 ifTrue: [brightness := 1000].
			brightness < 0 ifTrue: [brightness := 0].

			self bitmap: out at: i putH: hue s: saturation v: brightness]].

	interpreterProxy pop: 3.  "pop args, leave rcvr on stack"
	^ 0
