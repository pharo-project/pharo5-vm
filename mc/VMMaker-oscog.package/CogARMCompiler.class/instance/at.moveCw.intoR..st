generate machine code - concretize
at: offset moveCw: constant intoR: destReg
	"This loads aWord into the inter-opcode temporary register. Because most ARM instruction enable using a (8-12bit) offset relative to a register, the LS Byte can be included in that instruction, saving one instruction. This is done in a decorator, e.g. CmpCqR"
	"Generates:along the lines of
	MOV destReg, #<constantByte3>, 12
	ORR destReg, destReg, #<constantByte2>, 8
	ORR destReg, destReg, #<constantByte1>, 4
	ORR destReg, destReg, #<constantByte0>, 0
	with minimal choice of the rotation (last digit)"
	"The same area can be modified multiple times, because the opperation is (inclusive) or."
	<inline: true>
	0 to: 12 by: 4 do: [ :i | | rightRingRotation |
		rightRingRotation := self minimalRightRingRotationFor: constant initialRotation: 12 - i.
		machineCode
			at: offset + i + 3 put: 16rE3;
			at: offset + i + 2 put: (16r80 bitOr: destReg);
			at: offset + i + 1 put: ((rightRingRotation at: 1) bitOr: destReg << 4);
			at: offset + i"+0"put: (rightRingRotation at: 2).
		].
	machineCode at: offset + 2 put: 16rA0. "only the first operation need be MOV"
	^16