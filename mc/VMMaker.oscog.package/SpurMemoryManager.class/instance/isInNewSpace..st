object testing
isInNewSpace: objOop
	^(self oop: objOop isLessThan: newSpaceLimit)
	  and: [self oop: objOop isGreaterThanOrEqualTo: newSpaceStart]