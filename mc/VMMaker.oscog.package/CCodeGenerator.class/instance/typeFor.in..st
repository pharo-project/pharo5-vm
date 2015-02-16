type inference
typeFor: aNode in: aTMethod
	aNode isVariable ifTrue:
		[^(aTMethod typeFor: aNode in: self) ifNil: [#sqInt]].
	aNode isSend ifTrue:
		[^self returnTypeForSend: aNode in: aTMethod].
	^#sqInt