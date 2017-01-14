compile abstract instructions
compileFullBlockEntry
	<option: #SistaV1BytecodeSet>
	"Compile the abstract instructions for the entire method, including blocks."
	| jumpNoContextSwitch |

	"Abort for stack overflow on full block activation (no inline cache miss possible).
	 The flag is SendNumArgsReg."
	stackOverflowCall := self MoveCq: 0 R: ReceiverResultReg.
	backEnd hasLinkRegister ifTrue: [self PushR: LinkReg].
	"Since the only case in which this is called is the
	 stack overflow case we can reuse the trampoline."
	self Call: (self methodAbortTrampolineFor: methodOrBlockNumArgs).

	"Entries"
	"No context switch entry"
	fullBlockNoContextSwitchEntry := self MoveCq: 0 R: SendNumArgsReg.
	jumpNoContextSwitch := self Jump: 0.

	self AlignmentNops: (objectMemory wordSize max: 8).
	"Context switch entry (use ReceiverResultReg as a non-zero value; it's shorter)."
	fullBlockEntry := self MoveR: ReceiverResultReg R: SendNumArgsReg.
	jumpNoContextSwitch jmpTarget: self Label.

	^0