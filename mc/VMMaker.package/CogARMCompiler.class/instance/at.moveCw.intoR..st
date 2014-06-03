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
	"self assert: destReg < 12."

	self machineCodeAt: offset put: (self mov: destReg imm: (constant >>24 bitAnd: 16rFF) ror: 8).
	self machineCodeAt: offset +4 put: (self orr: destReg imm: (constant >> 16 bitAnd: 16rFF) ror: 16).
	self machineCodeAt: offset +8 put: (self orr: destReg imm: (constant >> 8 bitAnd: 16rFF) ror: 24).
	self machineCodeAt: offset +12 put: (self orr: destReg imm: (constant bitAnd: 16rFF) ror: 0).
	^16