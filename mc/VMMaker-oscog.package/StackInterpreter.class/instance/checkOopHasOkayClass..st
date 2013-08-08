debug support
checkOopHasOkayClass: obj
	"Attempt to verify that the given obj has a reasonable behavior. The class must be a
	 valid, non-integer oop and must not be nilObj. It must be a pointers object with three
	 or more fields. Finally, the instance specification field of the behavior must match that
	 of the instance. If OK answer true.  If  not, print reason and answer false."

	<api>
	<var: #oop type: #usqInt>
	| objClass formatMask behaviorFormatBits objFormatBits |
	<var: #oopClass type: #usqInt>

	(objectMemory checkOkayOop: obj) ifFalse:
		[^false].
	objClass := self cCoerce: (objectMemory fetchClassOfNonInt: obj) to: #usqInt.

	(objectMemory isIntegerObject: objClass) ifTrue:
		[self print: 'obj '; printHex: obj; print: ' a SmallInteger is not a valid class or behavior'; cr. ^false].
	(objectMemory okayOop: objClass) ifFalse:
		[self print: 'obj '; printHex: obj; print: ' class obj is not ok'; cr. ^false].
	((objectMemory isPointersNonInt: objClass) and: [(objectMemory lengthOf: objClass) >= 3]) ifFalse:
		[self print: 'obj '; printHex: obj; print: ' a class (behavior) must be a pointers object of size >= 3'; cr. ^false].
	formatMask := (objectMemory isBytes: obj)
						ifTrue: [16rC00]  "ignore extra bytes size bits"
						ifFalse: [16rF00].

	behaviorFormatBits := (objectMemory formatOfClass: objClass) bitAnd: formatMask.
	objFormatBits := (objectMemory baseHeader: obj) bitAnd: formatMask.
	behaviorFormatBits = objFormatBits ifFalse:
		[self print: 'obj '; printHex: obj; print: ' and its class (behavior) formats differ'; cr. ^false].
	^true