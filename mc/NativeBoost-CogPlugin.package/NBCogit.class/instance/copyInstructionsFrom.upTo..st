as yet unclassified
copyInstructionsFrom: start upTo: end
	"since there's only Fill32:
	we must align copied machine code size to 4-bytes filling the extra tail with NOP instructions"
	
	| position b1 b2 b3 b4 packedBytes |

	position := start.
	
	[ position < end ] whileTrue: [
		b1 := objectMemory byteAt: position.
		position := position + 1.

		(position < end) ifTrue: [ b2 := (objectMemory byteAt: position)] ifFalse: [ b2 := 16r90].
		position := position + 1.

		(position < end) ifTrue: [ b3 := (objectMemory byteAt: position)] ifFalse: [ b3 := 16r90].
		position := position + 1.

		(position < end) ifTrue: [ b4 := (objectMemory byteAt: position)] ifFalse: [ b4 := 16r90].
		position := position + 1.

		packedBytes := b1 + (b2<<8) + (b3<<16) + (b4<<24).
		self Fill32: packedBytes.
	].
	
	