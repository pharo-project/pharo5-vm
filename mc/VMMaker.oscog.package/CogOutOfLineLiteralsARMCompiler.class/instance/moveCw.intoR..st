generate machine code - support
moveCw: constant intoR: destReg
	"Emit a load of aWord into destReg.  Answer the number of bytes of machine code generated.
	 Literals are stored out-of-line; emit a LDR with the relevant offset."
	 <var: 'constant' type: #usqInt>
	<inline: true>
	self machineCodeAt: 0 put: (self ldr: destReg rn: PC plusImm: address - dependent address).
	^machineCodeSize := 4