accessing
sourceWith: anApplescriptInstance

	| theOSAID theSource|
	(theOSAID := self asOSAIDWith: anApplescriptInstance) ifNil: [^''].
	theSource := anApplescriptInstance sourceOfOSAID: theOSAID.
	theOSAID disposeWith: anApplescriptInstance.
	^theSource ifNil: [^''].