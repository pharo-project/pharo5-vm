debug support
checkOopHasOkayClass: obj
	"Attempt to verify that the given obj has a reasonable behavior. The class must be a
	 valid, non-integer oop and must not be nilObj. It must be a pointers object with three
	 or more fields. Finally, the instance specification field of the behavior must match that
	 of the instance. If OK answer true.  If  not, print reason and answer false."

	<api>
	<var: #obj type: #usqInt>
	| objClass objFormat |
	<var: #objClass type: #usqInt>

	(self checkOkayOop: obj) ifFalse:
		[^false].
	objClass := self cCoerce: (self fetchClassOfNonImm: obj) to: #usqInt.

	(self isImmediate: objClass) ifTrue:
		[self print: 'obj '; printHex: obj; print: ' an immediate is not a valid class or behavior'; cr. ^false].
	(self okayOop: objClass) ifFalse:
		[self print: 'obj '; printHex: obj; print: ' class obj is not ok'; cr. ^false].
	((self isPointersNonImm: objClass) and: [(self numSlotsOf: objClass) >= 3]) ifFalse:
		[self print: 'obj '; printHex: obj; print: ' a class (behavior) must be a pointers object of size >= 3'; cr. ^false].
	objFormat := (self isBytes: obj)
						ifTrue: [(self formatOf: obj) bitClear: 7]  "ignore extra bytes size bits"
						ifFalse: [self formatOf: obj].

	(self instSpecOfClass: objClass) ~= objFormat ifTrue:
		[self print: 'obj '; printHex: obj; print: ' and its class (behavior) formats differ'; cr. ^false].
	^true