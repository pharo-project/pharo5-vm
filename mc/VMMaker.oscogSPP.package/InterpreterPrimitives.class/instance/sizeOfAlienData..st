primitive support
sizeOfAlienData: oop
	"Answer the start of the Alien's data or fail if oop is not an Alien."
	<api>
	<returnTypeC: #usqInt>
	| size |
	(self is: oop KindOfClass: (objectMemory splObj: ClassAlien)) ifFalse:
		[self primitiveFailFor: PrimErrBadArgument.
		 ^0].
	size := self sizeFieldOfAlien: oop.
	^size abs