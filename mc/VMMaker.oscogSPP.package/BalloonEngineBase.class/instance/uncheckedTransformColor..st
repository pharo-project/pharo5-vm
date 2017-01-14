transforming
uncheckedTransformColor: fillIndex
	| r g b a transform |
	<var: #transform type:'float *'>
	(self hasColorTransform) ifFalse:[^fillIndex].
	b := fillIndex bitAnd: 255.
	g := (fillIndex >> 8) bitAnd: 255.
	r := (fillIndex >> 16) bitAnd: 255.
	a := (fillIndex >> 24) bitAnd: 255.
	transform := self colorTransform.
	r := (r * (transform at: 0) + (transform at: 1)) asInteger.
	g := (g * (transform at: 2) + (transform at: 3)) asInteger.
	b := (b * (transform at: 4) + (transform at: 5)) asInteger.
	a := (a * (transform at: 6) + (transform at: 7)) asInteger.
	r := r max: 0. r := r min: 255.
	g := g max: 0. g := g min: 255.
	b := b max: 0. b := b min: 255.
	a := a max: 0. a := a min: 255.
	a < 16 ifTrue:[^0]."ALWAYS return zero for transparent fills"
	^b + (g << 8) + (r << 16) + (a << 24)