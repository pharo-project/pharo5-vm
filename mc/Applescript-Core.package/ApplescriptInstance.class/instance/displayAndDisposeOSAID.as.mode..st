intermediate operations
displayAndDisposeOSAID: anOSAID as: aString mode: anInteger

	| anAEDesc result |
	anOSAID isEmpty ifTrue: [^AEDesc textTypeOn: ''].
	anAEDesc := AEDesc new.
	result := self 
		primOSADisplay: anOSAID 
		as: (DescType of: aString)
		mode: anInteger 
		to: anAEDesc.
	anOSAID disposeWith: self.
	result isZero ifFalse: 
		[^nil].
	^anAEDesc