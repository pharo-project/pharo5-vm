bytecode generator support
genNewArrayOfSize: size initialized: initialized
	"Generate a call to code that allocates a new Array of size.
	 The Array should be initialized with nils iff initialized is true.
	 The size arg is passed in SendNumArgsReg, the result
	 must come back in ReceiverResultReg."
	cogit
		MoveCq: size R: SendNumArgsReg;
		CallRT: ceCreateNewArrayTrampoline