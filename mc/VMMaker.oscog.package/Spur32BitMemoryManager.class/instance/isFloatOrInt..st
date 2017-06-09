interpreter access
isFloatOrInt: anOop
	"Answer if anOop is either a SmallInteger or a Float."

	<inline: true>
	^(self isImmediate: anOop)
		ifTrue: [self isIntegerObject: anOop]
		ifFalse: [(self classIndexOf: anOop) = ClassFloatCompactIndex]