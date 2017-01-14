object testing
isContext: oop
	<inline: true>
	^(self isNonImmediate: oop)
	   and: [(self classIndexOf: oop) = ClassMethodContextCompactIndex]