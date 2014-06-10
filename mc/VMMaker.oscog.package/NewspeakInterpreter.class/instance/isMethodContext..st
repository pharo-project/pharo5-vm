internal interpreter access
isMethodContext: oop
	<inline: true>
	^(self isNonIntegerObject: oop) and: [self isMethodContextHeader: (self baseHeader: oop)]