object testing
isOopImmutable: oop
	<api>
	^(self isImmediate: oop)
	  or: [self isImmutable: oop]