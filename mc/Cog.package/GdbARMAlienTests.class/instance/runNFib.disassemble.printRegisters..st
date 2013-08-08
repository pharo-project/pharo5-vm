execution
runNFib: n disassemble: disassemble printRegisters: printRegisters
	"Run nfib wth the argument. Answer the result."
	"self new runNFib: 5 disassemble: true printRegisters: true"
	| memory |
	memory := Bitmap new: 1024 * 2 withAll: self processor nopOpcode.
	memory replaceFrom: 1 to: self nfib size with: self nfib asWordArray startingAt: 1.
	self processor
		r0: n;"argument n"
		lr: memory size * 2; "return address"
		pc: 0;
		sp: (memory size * 4) - 16.
	printRegisters ifTrue:
		[self processor printRegistersOn: Transcript.
		 Transcript cr; flush].
	"run until something goes wrong."
	self processor runInMemory: memory readExecuteOnlyBelow: memory size / 2.
	printRegisters ifTrue:
		[self processor printRegistersOn: Transcript.
		 Transcript cr; flush].
	^self processor r0