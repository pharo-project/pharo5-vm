bundle strings
SqueakDebug
	^self isGenerateForRelease 
		ifTrue: [ 0 ]
		ifFalse: [ 1 ]