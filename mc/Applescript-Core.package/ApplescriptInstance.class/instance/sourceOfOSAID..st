interpreting
sourceOfOSAID: anOSAID

	| anAEDesc result |
	anAEDesc := AEDesc new.
	result := self primOSAGetSource: anOSAID type: 'TEXT' to: anAEDesc.
	anOSAID disposeWith: self.
	result isZero ifFalse: [^''].
	^anAEDesc asStringThenDispose
	
	