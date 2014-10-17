execution
singleStepNFib: n disassemble: disassemble printRegisters: printRegisters
	"Run nfib wth the argument. Answer the result."
	"self new runNFib: 5 disassemble: true printRegisters: true"
	| memory |
	memory := WordArray new: 1024 * 2 withAll: self processor nopOpcode.
	memory replaceFrom: 1 to: self nfib size with: self nfib asWordArray startingAt: 1.
	self processor
		r0: n; "argument n"
		lr: self nfib size * 4;  "return address"
		pc: 0;
		sp: (memory size * 4 - 12). "Room for return address, frame pointer and r4"
	printRegisters ifTrue:
		[self processor printRegistersOn: Transcript.
		 Transcript cr; flush].
	[disassemble ifTrue:
		[Transcript nextPutAll: (self processor disassembleNextInstructionIn: memory); cr; flush].
	 self processor singleStepIn: memory readExecuteOnlyBelow: memory size * 4 / 2.
	 printRegisters ifTrue:
		[self processor printRegistersOn: Transcript.
		 Transcript cr; flush].
	"stop, once we leave the nfib code and step through the nops after that."
	 self processor pc < (self nfib size * 4)] whileTrue.
	^self processor r0