contexts
isContextNonImm: oop
	<inline: true>
	^self isContextHeader: (self baseHeader: oop)