intermediate operations
storeOSAID: anOSAID type: aString mode: anInteger

	| theAEDesc result |
	theAEDesc := AEDesc new.
	result := self	
		primOSAStore: anOSAID 
		resultType: (DescType of: aString) 
		mode: 0  to: (theAEDesc).
	result isZero ifFalse: [^nil].
	^theAEDesc

