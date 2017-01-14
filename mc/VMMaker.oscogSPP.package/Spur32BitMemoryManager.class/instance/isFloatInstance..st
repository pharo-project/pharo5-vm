interpreter access
isFloatInstance: oop
	<inline: true>
	^(self isNonImmediate: oop)
	  and: [(self classIndexOf: oop) = ClassFloatCompactIndex]