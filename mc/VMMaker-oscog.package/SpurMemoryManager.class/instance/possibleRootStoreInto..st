store check
possibleRootStoreInto: destObj
	(#(	storePointer:ofObject:withValue:
		storePointer:ofForwarder:withValue:
		inPlaceBecome:and:copyHashFlag:) includes: thisContext sender method selector) ifFalse:
		[self halt].
	(self isRemembered: destObj) ifFalse:
		[scavenger remember: destObj.
		 self setIsRememberedOf: destObj to: true]