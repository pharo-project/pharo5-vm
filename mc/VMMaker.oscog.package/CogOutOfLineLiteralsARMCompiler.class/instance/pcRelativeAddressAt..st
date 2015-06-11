inline cacheing
pcRelativeAddressAt: address
	"Extract the address of the ldr rX, [pc, #NNN] instruction at address"
	| inst offset |
	inst := objectMemory longAt: address.
	self assert: (inst bitAnd: 16rFF5F0000) = (self ldr: 0 rn: PC plus: 0 imm: 0).
	offset := inst bitAnd: 16rFFF.
	^address + 8 + ((inst anyMask: 1 << 23)
						ifTrue: [offset]
						ifFalse: [offset negated])