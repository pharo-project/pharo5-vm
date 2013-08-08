primitive support
startOfAlienData: oop
	"Answer the start of the Alien's data or fail if oop is not an Alien."
	<api>
	<returnTypeC: #'void *'>
	(self is: oop KindOfClass: (self splObj: ClassAlien)) ifFalse:
		[self primitiveFailFor: PrimErrBadArgument.
		 ^0].
	^self cCoerceSimple: ((self sizeFieldOfAlien: oop) > 0
						 	ifTrue: [oop + BaseHeaderSize + BytesPerOop]
							ifFalse: [self longAt: oop + BaseHeaderSize + BytesPerOop])
			to: #'void *'