garbage collection
classRefInClosedPICAt: address
	<inline: true>
	"If inline cache tags are not objects they will be 32-bit values."
	"Current ARM out-of-line literal CPICs use
	ldr ip, [pc relative address1]
	cmp r0, ip
	ldr r6, [pc relative address2
	beq code
	hence the large backwards stepping here - address is pointing at the beq"
	^objectRepresentation inlineCacheTagsMayBeObjects
		ifFalse: [cogit backEnd literalBeforeFollowingAddress:  address - 8 "better to use 2 * instructionSize if we could, step back to the cmp so the literal is found properly" ]
		ifTrue: [self break. "not sure about this ? "objectMemory longAt: address - objectMemory bytesPerOop]