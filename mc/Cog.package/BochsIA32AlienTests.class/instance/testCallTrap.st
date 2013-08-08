tests
testCallTrap
	"Call a function that is out-of-range.  Ensure the call is trapped."
	"self new testCallTrap"
	| memory |
	 "The address is out of range of memory every which way (whether relative or absolute and whether big-endian or little."
	memory := ByteArray new: 1024.
	memory replaceFrom: 1 to: 5 with: { self processor callOpcode. 0. 16r80. 16r80. 0. } asByteArray.
	self processor
			eip: 0;
			esp: (memory size - 4). "Room for return address"
	self should: [self processor singleStepIn: memory]
		raise: ProcessorSimulationTrap
		withExceptionDo:
			[:pst|
			self assert: pst address = ((memory longAt: 2 bigEndian: false) + 5 "length of call instr").
			self assert: pst pc = 0.
			self assert: pst type = #call].

	"| memory |
	memory := ByteArray new: 1024.
	memory replaceFrom: 1 to: 5 with: { BochsIA32Alien new callOpcode. 0. 16r80. 16r80. 0. } asByteArray.
	BochsIA32AlienTests new processor
		eip: 0;
		esp: (memory size - 4);
		singleStepIn: memory;
		printRegistersOn: Transcript.
	Transcript flush"