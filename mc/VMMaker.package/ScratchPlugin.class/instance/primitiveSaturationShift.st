hsv filters
primitiveSaturationShift

	| inOop outOop shift in sz out pix r g b max min brightness saturation hue |
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
		pix < 2 ifFalse: [  "skip pixel values of 0 (transparent) and 1 (black)"
			r := (pix bitShift: -16) bitAnd: 16rFF.
			g := (pix bitShift: -8) bitAnd: 16rFF.
			b := pix bitAnd: 16rFF.

			"find min and max color components"
			max := min := r.
			g > max ifTrue: [max := g].
			b > max ifTrue: [max := b].
			g < min ifTrue: [min := g].
			b < min ifTrue: [min := b].

			"find current brightness (v) and  saturation with range 0 to 1000"
			brightness := (max * 1000) // 255.
			max = 0 ifTrue: [saturation := 0] ifFalse: [saturation := ((max - min) * 1000) // max].

			saturation > 0 ifTrue: [  "do nothing if pixel is unsaturated (gray)"
				hue := self hueFromR: r G: g B: b min: min max: max.

				"compute new saturation"
				saturation := saturation + (shift * 10).
				saturation > 1000 ifTrue: [saturation := 1000].
				saturation < 0 ifTrue: [saturation := 0].
				self bitmap: out at: i putH: hue s: saturation v: brightness]]].

	interpreterProxy pop: 3.  "pop args, leave rcvr on stack"
	^ 0
