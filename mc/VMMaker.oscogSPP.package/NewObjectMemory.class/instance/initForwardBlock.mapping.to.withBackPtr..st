gc -- compaction
initForwardBlock: fwdBlock mapping: objOop to: newOop withBackPtr: backFlag
	"Initialize the given forwarding block to map oop to newOop, 
	and replace oop's header with a pointer to the fowarding block."
	"Details: The mark bit is used to indicate that an oop is 
	forwarded. When an oop is forwarded, its header (minus the 
	mark bit) contains the address of its forwarding block. (The 
	forwarding block address is actually shifted right by one bit 
	so that its top-most bit does not conflict with the header's 
	mark bit; since fowarding blocks are stored on word 
	boundaries, the low two bits of the address are always zero.) 
	The first word of the forwarding block is the new oop; the 
	second word is the oop's orginal header. In the case of a 
	forward become, a four-word block is used, with the third 
	field being a backpointer to the old oop (for header fixup), 
	and the fourth word is unused. The type bits of the 
	forwarding header are the same as those of the original 
	header. "
	| originalHeader originalHeaderType |
	<inline: true>
	self assert: fwdBlock ~= nil. "ran out of forwarding blocks in become"
	self deny: (self hasForwardingBlock: objOop). "'object already has a forwarding table entry"
	originalHeader := self longAt: objOop.
	originalHeaderType := originalHeader bitAnd: TypeMask.
	self longAt: fwdBlock put: newOop.
	self longAt: fwdBlock + self wordSize put: originalHeader.
	backFlag ifTrue: [self longAt: fwdBlock + (self wordSize*2) put: objOop].
	self longAt: objOop put: (fwdBlock >> 1 bitOr: (MarkBit bitOr: originalHeaderType))