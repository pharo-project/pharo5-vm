debug support
checkOopHasOkayClass: obj
	"Attempt to verify that the given obj has a reasonable behavior. The class must be a
	 valid, non-integer oop and must not be nilObj. It must be a pointers object with three
	 or more fields. Finally, the instance specification field of the behavior must match that
	 of the instance. If OK answer true.  If  not, print reason and answer false."

	<api>
	<var: #obj type: #usqInt>
	| objClass formatMask behaviorFormatBits objFormatBits |
	<var: #objClass type: #usqInt>

	(self checkOkayOop: obj) ifFalse:
		[^false].
	objClass := self cCoerce: (self fetchClassOfNonImm: obj) to: #usqInt.

	(self isIntegerObject: objClass) ifTrue:
		[self print: 'obj '; printHex: obj; print: ' a SmallInteger is not a valid class or behavior'; cr. ^false].
	(self okayOop: objClass) ifFalse:
		[self print: 'obj '; printHex: obj; print: ' class obj is not ok'; cr. ^false].
	((self isPointersNonImm: objClass) and: [(self lengthOf: objClass) >= 3]) ifFalse:
		[self print: 'obj '; printHex: obj; print: ' a class (behavior) must be a pointers object of size >= 3'; cr. ^false].
	formatMask := (self isBytes: obj)
						ifTrue: [16rC00]  "ignore extra bytes size bits"
						ifFalse: [16rF00].

	behaviorFormatBits := (self formatOfClass: objClass) bitAnd: formatMask.
	objFormatBits := (self baseHeader: obj) bitAnd: formatMask.
	behaviorFormatBits = objFormatBits ifFalse:
		[self print: 'obj '; printHex: obj; print: ' and its class (behavior) formats differ'; cr. ^false].
	^true