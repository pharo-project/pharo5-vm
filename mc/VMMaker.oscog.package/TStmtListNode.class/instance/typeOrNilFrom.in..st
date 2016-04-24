type inference
typeOrNilFrom: aCodeGenerator in: aTMethod
	statements isEmpty ifTrue: [^nil].
	^statements last typeOrNilFrom: aCodeGenerator in: aTMethod