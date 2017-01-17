private
saveTo: origKlattOop
	| pitchOop a1Oop a2Oop x1Oop x2Oop b1Oop c1Oop glastOop vlastOop nlastOop klattOop |
	interpreterProxy pushRemappableOop: origKlattOop.
	interpreterProxy pushRemappableOop: (interpreterProxy floatObjectOf: pitch).
	interpreterProxy pushRemappableOop: (interpreterProxy floatObjectOf: a1).
	interpreterProxy pushRemappableOop: (interpreterProxy floatObjectOf: a2).
	interpreterProxy pushRemappableOop: (interpreterProxy floatObjectOf: x1).
	interpreterProxy pushRemappableOop: (interpreterProxy floatObjectOf: x2).
	interpreterProxy pushRemappableOop: (interpreterProxy floatObjectOf: b1).
	interpreterProxy pushRemappableOop: (interpreterProxy floatObjectOf: c1).
	interpreterProxy pushRemappableOop: (interpreterProxy floatObjectOf: glast).
	interpreterProxy pushRemappableOop: (interpreterProxy floatObjectOf: vlast).
	nlastOop := interpreterProxy floatObjectOf: nlast.
	vlastOop := interpreterProxy popRemappableOop.
	glastOop := interpreterProxy popRemappableOop.
	c1Oop := interpreterProxy popRemappableOop.
	b1Oop := interpreterProxy popRemappableOop.
	x2Oop := interpreterProxy popRemappableOop.
	x1Oop := interpreterProxy popRemappableOop.
	a2Oop := interpreterProxy popRemappableOop.
	a1Oop := interpreterProxy popRemappableOop.
	pitchOop := interpreterProxy popRemappableOop.
	klattOop := interpreterProxy popRemappableOop.
	interpreterProxy failed ifTrue:[^ false].

	interpreterProxy storePointer: 2 ofObject: klattOop withValue: pitchOop.
	interpreterProxy storeInteger: 3 ofObject: klattOop withValue: t0.
	interpreterProxy storeInteger: 4 ofObject: klattOop withValue: nper.
	interpreterProxy storeInteger: 5 ofObject: klattOop withValue: nopen.
	interpreterProxy storeInteger: 6 ofObject: klattOop withValue: nmod.
	interpreterProxy storePointer: 7 ofObject: klattOop withValue: a1Oop.
	interpreterProxy storePointer: 8 ofObject: klattOop withValue: a2Oop.
	interpreterProxy storePointer: 9 ofObject: klattOop withValue: x1Oop.
	interpreterProxy storePointer: 10 ofObject: klattOop withValue: x2Oop.
	interpreterProxy storePointer: 11 ofObject: klattOop withValue: b1Oop.
	interpreterProxy storePointer: 12 ofObject: klattOop withValue: c1Oop.
	interpreterProxy storePointer: 13 ofObject: klattOop withValue: glastOop.
	interpreterProxy storePointer: 14 ofObject: klattOop withValue: vlastOop.
	interpreterProxy storePointer: 15 ofObject: klattOop withValue: nlastOop.
	interpreterProxy storeInteger: 16 ofObject: klattOop withValue: periodCount.
	interpreterProxy storeInteger: 17 ofObject: klattOop withValue: samplesCount.
	interpreterProxy storeInteger: 18 ofObject: klattOop withValue: seed.

	^ interpreterProxy failed == false