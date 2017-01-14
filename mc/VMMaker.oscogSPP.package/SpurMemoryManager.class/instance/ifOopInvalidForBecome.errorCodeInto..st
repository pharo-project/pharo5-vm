become implementation
ifOopInvalidForBecome: oop errorCodeInto: aBlock
	"Evaluates aBlock with an appropriate error if oop is invalid for become."
	<inline: true>
	(self isImmediate: oop) ifTrue:
		[^aBlock value: PrimErrInappropriate].
	(self isPinned: oop) ifTrue:
		[^aBlock value: PrimErrObjectIsPinned].
	(self isObjImmutable: oop) ifTrue:
		[^aBlock value: PrimErrNoModification]