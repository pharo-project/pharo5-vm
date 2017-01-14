private-cacheing
objectForOop: anOop
	"This is a keyAtValue: search and so needs speeding up either by a reverse map or a simple cache."
	^(anOop bitAnd: 3) caseOf: {
		[0] -> [anOop = cachedOop
				ifTrue: [cachedObject]
				ifFalse: [cachedObject := objectMap keyAtValue: anOop. "may raise Error"
						cachedOop := anOop. "Dom't assign until accessed without error"
						cachedObject]].
		[1] -> [anOop signedIntFromLong64 >> 3].
		[2] -> [Character value: anOop >> 3].
		[3] -> [objectMemory smallFloatValueOf: anOop] }