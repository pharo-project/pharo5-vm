initialization
generateSistaRuntime
	"Class trap sends class trap message to context with top of stack, so we on't need any arguments..."
	ceClassTrapTrampoline := self genTrampolineFor: #ceClassTrap:
									called: 'ceClassTrapTrampoline'
									arg: ReceiverResultReg