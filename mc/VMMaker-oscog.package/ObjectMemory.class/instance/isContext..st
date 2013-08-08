contexts
isContext: oop
	<inline: true>
	^(self isNonIntegerObject: oop) and: [self isContextHeader: (self baseHeader: oop)]