image segment in/out
oopHasAcceptableClass: signedOop
	"Similar to oopHasOkayClass:, except that it only returns true or false."

	| oopClass formatMask behaviorFormatBits oopFormatBits oop |
	<var: #oop type: #usqInt>
	<var: #oopClass type: #usqInt>

	(self isIntegerObject: signedOop) ifTrue: [^ true].

	oop := self cCoerce: signedOop to: #usqInt.
	(self addressCouldBeObj: oop) ifFalse: [^ false].

	oopClass := self cCoerce: (self fetchClassOfNonImm: oop) to: #usqInt.
	(self addressCouldBeObj: oopClass) ifFalse: [^ false].
	(oopClass + (self sizeBitsOf: oopClass)) < freeBlock ifFalse: [^ false].

	((self isPointersNonImm: oopClass) and: [(self lengthOf: oopClass) >= 3]) ifFalse: [^ false].

	formatMask := (self isBytesNonImm: oop)
						ifTrue: [16rC00]  "ignore extra bytes size bits"
						ifFalse: [16rF00].

	behaviorFormatBits := (self formatOfClass: oopClass) bitAnd: formatMask.
	oopFormatBits := (self baseHeader: oop) bitAnd: formatMask.
	behaviorFormatBits = oopFormatBits ifFalse: [^ false].
	^ true