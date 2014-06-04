transforming
transformColor: fillIndex
	| r g b a transform alphaScale |
	<var: #transform type:'float *'>
	<var: #alphaScale type:'double '>
	(fillIndex = 0 or:[self isFillColor: fillIndex]) ifFalse:[^fillIndex].
	b := fillIndex bitAnd: 255.
	g := (fillIndex >> 8) bitAnd: 255.
	r := (fillIndex >> 16) bitAnd: 255.
	a := (fillIndex >> 24) bitAnd: 255.
	(self hasColorTransform) ifTrue:[
		transform := self colorTransform.
		alphaScale := (a * (transform at: 6) + (transform at: 7)) / a.
		r := (r * (transform at: 0) + (transform at: 1) * alphaScale) asInteger.
		g := (g * (transform at: 2) + (transform at: 3) * alphaScale) asInteger.
		b := (b * (transform at: 4) + (transform at: 5) * alphaScale) asInteger.
		a := a * alphaScale.
		r := r max: 0. r := r min: 255.
		g := g max: 0. g := g min: 255.
		b := b max: 0. b := b min: 255.
		a := a max: 0. a := a min: 255.
	].
	a < 1 ifTrue:[^0]."ALWAYS return zero for transparent fills"
	"If alpha is not 255 (or close thereto) then we need to flush the engine before proceeding"
	(a < 255 and:[self needsFlush]) 
		ifTrue:[self stopBecauseOf: GErrorNeedFlush].
	^b + (g << 8) + (r << 16) + (a << 24)