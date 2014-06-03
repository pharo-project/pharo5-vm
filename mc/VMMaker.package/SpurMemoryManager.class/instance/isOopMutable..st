object testing
isOopMutable: oop
	<api>
	^(self isNonImmediate: oop)
	  and: [(self isImmutable: oop) not]