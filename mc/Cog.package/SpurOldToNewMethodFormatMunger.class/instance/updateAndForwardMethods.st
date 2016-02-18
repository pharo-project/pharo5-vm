munging
updateAndForwardMethods
	| new now lastDotTime |
	new := Set new: 1000.
	lastDotTime := Time now asSeconds.
	heap allObjectsDo:
		[:obj|
		((heap isCompiledMethod: obj)
		 and: [(new includes: obj) not]) ifTrue:
			[| header |
			 (heap primitiveIndexOfMethodHeader: (header := heap methodHeaderOf: obj)) > 0
				ifTrue:
					[new add: (self mungePrimitiveMethod: obj).
					 (now := Time now asSeconds) > lastDotTime ifTrue:
						[Transcript nextPut: $.; flush.
						 lastDotTime := now]]
				ifFalse:
					[heap
						storePointerUnchecked: 0
						ofObject: obj
						withValue: (self convertOldMethodHeader: header)]]].
	Spur32BitMMLESimulator adoptInstance: interpreter objectMemory.
	self withExecutableInterpreter: interpreter
		do: [self replaceMethods]