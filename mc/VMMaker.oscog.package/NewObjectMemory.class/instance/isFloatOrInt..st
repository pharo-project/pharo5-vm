interpreter access
isFloatOrInt: anOop
	"Answer if anOop is either a SmallInteger or a Float."

	<inline: true>

	^(self isIntegerObject: anOop)
	  or: [(self compactClassIndexOf: anOop) = ClassFloatCompactIndex]