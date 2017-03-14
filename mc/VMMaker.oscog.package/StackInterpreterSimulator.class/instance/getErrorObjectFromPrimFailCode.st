debugging traps
getErrorObjectFromPrimFailCode
	(primFailCode > 1 and: [(#(primitiveNew primitiveFetchNextMourner) includes: primitiveFunctionPointer) not]) ifTrue: [self halt].
	^super getErrorObjectFromPrimFailCode