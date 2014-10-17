execution
singleStepNFib: n disassemble: disassemble printRegisters: printRegisters
	"Run nfib wth the argument. Answer the result."
	"self new runNFib: 5 disassemble: true printRegisters: true"
	| memory finalSP |
	memory := ByteArray new: 4096 * 2 withAll: self processor nopOpcode.
	finalSP := memory size - 4. "Stop when we return to the nop following nfib"
	memory
		replaceFrom: 1 to: self nfib size with: self nfib asByteArray startingAt: 1;
		longAt: memory size - 3 put: n bigEndian: false; "argument n"
		longAt: memory size - 7 put: self nfib size bigEndian: false.  "return address"
	self processor
			eip: 0;
			esp: (memory size - 8). "Room for return address and argument n"
	printRegisters ifTrue:
		[self processor printRegistersOn: Transcript.
		 Transcript cr; flush].
	[disassemble ifTrue:
		[Transcript nextPutAll: (self processor disassembleNextInstructionIn: memory); cr; flush].
	 self processor singleStepIn: memory readExecuteOnlyBelow: memory size / 2.
	 printRegisters ifTrue:
		[self processor printRegistersOn: Transcript.
		 Transcript cr; flush].
	 self processor esp ~= finalSP] whileTrue.
	^self processor eax