internal interpreter access
isKindOfInteger: oop
	"Answer true if the oop is kind of Integer (Small or Large)."
	<api>
	<inline: true>
	^(objectMemory isIntegerObject: oop)
		or: [objectMemory isLargeIntegerInstance: oop]