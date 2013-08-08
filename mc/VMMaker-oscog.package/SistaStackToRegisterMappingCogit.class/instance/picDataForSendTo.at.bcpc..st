method introspection
picDataForSendTo: cogMethod at: sendMcpc bcpc: sendBcpc
	<var: #cogMethod type: #'CogMethod *'>
	<var: #sendMcpc type: #'char *'>
	| tuple |
	cogMethod cmType = CMMethod ifTrue:
		[tuple := objectMemory
					eeInstantiateClass: (objectMemory splObj: ClassArray)
					indexableSize: 3.
		tuple = 0 ifTrue:
			[^0].
		objectMemory
			storePointerUnchecked: 0 ofObject: tuple withValue: (objectMemory integerObjectOf: sendBcpc);
			storePointer: 1 ofObject: tuple withValue: cogMethod methodObject;
			storePointer: 2
				ofObject: tuple
					withValue: (objectRepresentation classForInlineCacheTag: (backEnd inlineCacheTagAt: sendMcpc asUnsignedInteger)).
		^tuple].
	cogMethod cmType = CMClosedPIC ifTrue:
		[tuple := objectMemory
					eeInstantiateClass: (objectMemory splObj: ClassArray)
					indexableSize: 2 * cogMethod cPICNumCases + 1.
		tuple = 0 ifTrue:
			[^0].
		objectMemory storePointerUnchecked: 0 ofObject: tuple withValue: (objectMemory integerObjectOf: sendBcpc).
		self populate: tuple withPICInfoFor: cogMethod firstCacheTag: (backEnd inlineCacheTagAt: sendMcpc asUnsignedInteger).
		^tuple].
	cogMethod cmType = CMOpenPIC ifTrue:
		[tuple := objectMemory
					eeInstantiateClass: (objectMemory splObj: ClassArray)
					indexableSize: 2.
		tuple = 0 ifTrue:
			[^0].
		coInterpreter
			storeInteger: 0 ofObject: tuple withValue: sendBcpc;
			storePointerUnchecked: 1 ofObject: tuple withValue: objectMemory nilObject.
		^tuple].
	self error: 'invalid method type'.
	^0 "to get Slang to type this method as answering sqInt"