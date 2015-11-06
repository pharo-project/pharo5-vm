garbage collection
storeClassRef: classObj inClosedPICAt: address
	<var: #address type: #usqInt>
	<inline: true>
	"If inline cache tags are not objects they will be 32-bit values."
	"Current ARM out-of-line literal CPICs use
	ldr ip, [pc relative address1]
	cmp r0, ip
	ldr r6, [pc relative address2
	beq code
	hence the large backwards stepping here"
	objectRepresentation inlineCacheTagsMayBeObjects
		ifTrue: [self break. objectMemory long32At: address - 4 put: classObj]
		ifFalse: [cogit backEnd storeLiteral: classObj beforeFollowingAddress:  address - 8 "better to use 2 * instructionSize if we could, step back to the cmp so the literal is found properly"]