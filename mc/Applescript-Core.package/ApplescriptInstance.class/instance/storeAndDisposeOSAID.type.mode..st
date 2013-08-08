intermediate operations
storeAndDisposeOSAID: anOSAID type: aString mode: anInteger

	| theAEDesc result |
	theAEDesc := AEDesc new.
	result := self	
		primOSAStore: anOSAID 
		resultType: (DescType of: aString) 
		mode: 0  to: (theAEDesc).
	anOSAID disposeWith: self.
	result isZero ifFalse: [^nil].
	^theAEDesc

