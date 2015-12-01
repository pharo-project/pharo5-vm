inline cacheing
jumpLongConditionalTargetBeforeFollowingAddress: mcpc
	"mcpc - 16:	beq/ne Cmp, ZR, +12
	 mcpc - 12:	nop (delay slot)
	 mcpc - 8:	j psuedo-address
	 mcpc - 4:	nop (delay slot)"		
	self assert: (((self opcodeAtAddress: mcpc - 16) == BEQ) 
				or: [(self opcodeAtAddress: mcpc - 16) == BNE]).
	self assert: (objectMemory longAt: mcpc - 12) == self nop. "Delay slot"
	self assert: (self opcodeAtAddress: mcpc - 8) == J.
	self assert: (objectMemory longAt: mcpc - 4) == self nop. "Delay slot"
	^self targetFromJTypeAtAddress: mcpc - 8