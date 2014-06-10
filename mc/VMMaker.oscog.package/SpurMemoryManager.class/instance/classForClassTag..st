interpreter access
classForClassTag: classIndex
	self assert: classIndex ~= self isForwardedObjectClassIndexPun.
	^self classAtIndex: classIndex