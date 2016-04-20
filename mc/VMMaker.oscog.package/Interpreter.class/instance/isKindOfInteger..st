plugin primitive support
isKindOfInteger: oop
	"Answer true if the oop is kind of Integer (Small or Large)."
	<api>
	<inline: true>
	^(self isIntegerObject: oop)
		or: [self isLargeIntegerInstance: oop]