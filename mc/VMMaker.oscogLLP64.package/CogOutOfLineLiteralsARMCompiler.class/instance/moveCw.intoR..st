generate machine code - support
moveCw: constant intoR: destReg
	"Emit a load of aWord into destReg.  Answer the number of bytes of machine code generated.
	 Literals are stored out-of-line; emit a LDR with the relevant offset."
	 <var: 'constant' type: #usqInt>
	<inline: true>
	self assert: (cogit addressIsInCurrentCompilation: dependent address).
	self assert: (dependent address - (address + 8)) abs < (1<<12).
	self machineCodeAt: 0
		put: (self
				ldr: destReg
				rn: PC
				plus: (dependent address >= (address + 8) ifTrue: [1] ifFalse: [0])
				imm: (dependent address - (address + 8)) abs).
	^machineCodeSize := 4