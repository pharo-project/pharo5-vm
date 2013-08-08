private
on: aString mode: anInteger onErrorDo: aBlock

	source := aString.
	compiledScript := ApplescriptGeneric compile: aString mode: anInteger.
	compiledScript ifNil: [^aBlock value].
	^self