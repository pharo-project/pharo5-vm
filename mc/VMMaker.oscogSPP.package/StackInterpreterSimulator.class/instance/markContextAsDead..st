frame access
markContextAsDead: oop
	"(self withoutSmallIntegerTags: (objectMemory fetchPointer: SenderIndex ofObject: oop)) = -16r26824 ifTrue:
		[self halt]."
	^super markContextAsDead: oop