object testing
isOopForwarded: oop
	<api>
	^(self isNonImmediate: oop)
	  and: [(self classIndexOf: oop) = self isForwardedObjectClassIndexPun]