tests
testMoveRAw
	"Write a register to a constant address that is in-range."
	
	"self new testMoveRAw"
	| memory |
	memory := self memory.
	self processor reset.

	"LEA sl, #16r3FC"
	memory unsignedLongAt: 5 put: (CogARMCompiler new mov: 10 imm: 0 ror: 0)  bigEndian: false. 
	memory unsignedLongAt: 9 put: (CogARMCompiler new orr: 10 imm: 0 ror: 0) bigEndian: false.
	memory unsignedLongAt: 13 put: (CogARMCompiler new orr: 10 imm: 2 ror: 24) bigEndian: false. 
	memory unsignedLongAt: 17 put: (CogARMCompiler new orr: 10 imm: 40 ror: 0) bigEndian: false. 
	"STR R5, [sl]"
	memory unsignedLongAt: 21 put: (CogARMCompiler new str: 5 rn: 10 plusImm: 0) bigEndian: false.

	
	"processor disassembleFrom: 0 to: 60 in: memory on: Transcript cr"
	self processor
			pc: 4;
			sp: (memory size - 4); "Room for return address"
			r5: 99;
			singleStepIn: memory readExecuteOnlyBelow: memory size / 2.
			"We have to step several times, because the first step only changes the pc, but does not fetch anything from the address it points to."
	self processor singleStepIn: memory readExecuteOnlyBelow: memory size / 2.
	self processor singleStepIn: memory readExecuteOnlyBelow: memory size / 2.
	self processor singleStepIn: memory readExecuteOnlyBelow: memory size / 2.
	self processor singleStepIn: memory readExecuteOnlyBelow: memory size / 2.
	self processor singleStepIn: memory readExecuteOnlyBelow: memory size / 2.
	self assert:[(memory unsignedLongAt: (processor sl) + 1) = processor r5]
