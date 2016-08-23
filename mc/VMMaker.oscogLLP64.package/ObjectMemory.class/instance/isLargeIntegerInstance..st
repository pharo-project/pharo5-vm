interpreter access
isLargeIntegerInstance: oop
	<inline: true>
	^(self isInstanceOfClassLargePositiveInteger: oop)
		or: [self isInstanceOfClassLargeNegativeInteger: oop]