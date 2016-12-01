accessing
numIntRegArgs
	^SysV ifTrue: [6] ifFalse: [4]