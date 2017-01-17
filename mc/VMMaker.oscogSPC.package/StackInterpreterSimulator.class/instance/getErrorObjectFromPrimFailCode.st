debugging traps
getErrorObjectFromPrimFailCode
	primFailCode > 1 ifTrue: [self halt].
	^super getErrorObjectFromPrimFailCode