accessing
numTrampolines
	^1 "ceStoreCheckTrampoline" + (LowcodeVM ifTrue: [ 9 ] ifFalse: [ 0 ])