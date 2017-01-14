method introspection
picDataForSendTo: cogMethod methodClassIfSuper: methodClassOrNil at: sendMcpc bcpc: sendBcpc
	"Answer a tuple with the send data for a linked send to cogMethod.
	 If the target is a CogMethod (monomorphic send) answer
		{ bytecode pc, inline cache class, target method }
	 If the target is an open PIC (megamorphic send) answer
		{ bytecode pc, nil, send selector }
	If the target is a closed PIC (polymorphic send) answer
		{ bytecode pc, first class, target method, second class, second target method, ... }"
	<var: #cogMethod type: #'CogMethod *'>
	<var: #sendMcpc type: #'char *'>
	| tuple class |
	tuple := objectMemory
					eeInstantiateClassIndex: ClassArrayCompactIndex
					format: objectMemory arrayFormat
					numSlots: (cogMethod cmType = CMClosedPIC
								ifTrue: [2 * cogMethod cPICNumCases + 1]
								ifFalse: [3]).
	tuple = 0 ifTrue:
		[^0].
	objectMemory storePointerUnchecked: 0 ofObject: tuple withValue: (objectMemory integerObjectOf: sendBcpc).
	cogMethod cmType = CMMethod ifTrue:
		[class := methodClassOrNil ifNil:
					[objectRepresentation classForInlineCacheTag: (backEnd inlineCacheTagAt: sendMcpc asUnsignedInteger)].
		 objectMemory
			storePointer: 1 ofObject: tuple withValue: class;
			storePointer: 2 ofObject: tuple withValue: cogMethod methodObject.
		^tuple].
	cogMethod cmType = CMClosedPIC ifTrue:
		[self populate: tuple withPICInfoFor: cogMethod firstCacheTag: (backEnd inlineCacheTagAt: sendMcpc asUnsignedInteger).
		^tuple].
	cogMethod cmType = CMOpenPIC ifTrue:
		[objectMemory
			storePointerUnchecked: 1 ofObject: tuple withValue: objectMemory nilObject;
			storePointer: 2 ofObject: tuple withValue: cogMethod selector.
		^tuple].
	self error: 'invalid method type'.
	^0 "to get Slang to type this method as answering sqInt"