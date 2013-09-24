object testing
isOopForwarded: oop
	^(self isNonImmediate: oop)
	  and: [(self classIndexOf: oop) = self isForwardedObjectClassIndexPun]