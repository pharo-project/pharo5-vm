debug support
assertValidExecutionPointe: lip r: lfp s: lsp imbar: inInterpreter line: ln
	<var: #lip type: #usqInt>
	<var: #lfp type: #'char *'>
	<var: #lsp type: #'char *'>
	self assert: inInterpreter l: ln.
	self assert: stackPage = stackPages mostRecentlyUsedPage l: ln.
	self assertValidStackLimits: ln.
	self assert: (stackPage addressIsInPage: lfp) l: ln.
	self assert: lsp < lfp l: ln.
	self assert: lfp > lsp l: ln.
	self assert: lsp >= (stackPage realStackLimit - self stackLimitOffset) l: ln.
	self assert: (lfp - lsp) / objectMemory bytesPerOop < LargeContextSlots l: ln.
	self assert: (self validInstructionPointer: lip inFrame: lfp) l: ln.
	self assert: ((self frameIsBlockActivation: lfp)
				or: [(self pushedReceiverOrClosureOfFrame: lfp) = (self frameReceiver: lfp)])
		l: ln.
	self assert: method = (self frameMethod: lfp) l: ln.
	self cppIf: MULTIPLEBYTECODESETS
		ifTrue: [self assert: (self methodUsesAlternateBytecodeSet: method) = (bytecodeSetSelector = 256)  l: ln].