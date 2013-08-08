debug support
oopHasOkayClass: signedOop
	"Attempt to verify that the given oop has a reasonable behavior. The class must be a valid, non-integer oop and must not be nilObj. It must be a pointers object with three or more fields. Finally, the instance specification field of the behavior must match that of the instance."

	| oop oopClass formatMask behaviorFormatBits oopFormatBits |
	<var: #oop type: #usqInt>
	<var: #oopClass type: #usqInt>

	oop := self cCoerce: signedOop to: #usqInt.
	objectMemory okayOop: oop.
	oopClass := self cCoerce: (objectMemory fetchClassOf: oop) to: #usqInt.

	(objectMemory isIntegerObject: oopClass)
		ifTrue: [ self error: 'a SmallInteger is not a valid class or behavior'. ^false ].
	(objectMemory okayOop: oopClass)
		ifFalse: [ self error: 'class oop is not ok'. ^false ].
	((objectMemory isPointersNonInt: oopClass) and: [(objectMemory lengthOf: oopClass) >= 3])
		ifFalse: [ self error: 'a class (behavior) must be a pointers object of size >= 3'. ^false ].
	(objectMemory isBytes: oop)
		ifTrue: [ formatMask := 16rC00 ]  "ignore extra bytes size bits"
		ifFalse: [ formatMask := 16rF00 ].

	behaviorFormatBits := (objectMemory formatOfClass: oopClass) bitAnd: formatMask.
	oopFormatBits := (objectMemory baseHeader: oop) bitAnd: formatMask.
	behaviorFormatBits = oopFormatBits
		ifFalse: [ self error: 'object and its class (behavior) formats differ'. ^false ].
	^true