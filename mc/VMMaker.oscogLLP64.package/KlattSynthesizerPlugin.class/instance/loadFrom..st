private
loadFrom: klattOop
	| oop |
	interpreterProxy success: (interpreterProxy slotSizeOf: klattOop) = 22.
	interpreterProxy failed ifTrue:[^ false].

	oop := interpreterProxy fetchPointer: 0 ofObject: klattOop.
	resonators := self checkedFloatPtrOf: oop.

	pitch := interpreterProxy fetchFloat: 2 ofObject: klattOop.
	t0 := interpreterProxy fetchInteger: 3 ofObject: klattOop.
	nper := interpreterProxy fetchInteger: 4 ofObject: klattOop.
	nopen := interpreterProxy fetchInteger: 5 ofObject: klattOop.
	nmod := interpreterProxy fetchInteger: 6 ofObject: klattOop.
	a1 := interpreterProxy fetchFloat: 7 ofObject: klattOop.
	a2 := interpreterProxy fetchFloat: 8 ofObject: klattOop.
	x1 := interpreterProxy fetchFloat: 9 ofObject: klattOop.
	x2 := interpreterProxy fetchFloat: 10 ofObject: klattOop.
	b1 := interpreterProxy fetchFloat: 11 ofObject: klattOop.
	c1 := interpreterProxy fetchFloat: 12 ofObject: klattOop.
	glast := interpreterProxy fetchFloat: 13 ofObject: klattOop.
	vlast := interpreterProxy fetchFloat: 14 ofObject: klattOop.
	nlast := interpreterProxy fetchFloat: 15 ofObject: klattOop.
	periodCount := interpreterProxy fetchInteger: 16 ofObject: klattOop.
	samplesCount := interpreterProxy fetchInteger: 17 ofObject: klattOop.
	seed := interpreterProxy fetchInteger: 18 ofObject: klattOop.
	cascade := interpreterProxy fetchInteger: 19 ofObject: klattOop.
	samplesPerFrame := interpreterProxy fetchInteger: 20 ofObject: klattOop.
	samplingRate := interpreterProxy fetchInteger: 21 ofObject: klattOop.

	^ interpreterProxy failed == false