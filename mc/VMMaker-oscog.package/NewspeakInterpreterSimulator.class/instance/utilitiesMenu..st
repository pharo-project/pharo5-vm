UI
utilitiesMenu: aMenuMorph
	aMenuMorph
		add: 'toggle transcript' action: #toggleTranscript;
		addLine;
		add: 'print active context' action: [self printContext: activeContext WithSP: localSP];
		add: 'print int head frame' action: #printHeadFrame;
		add: 'print call stack' action: #printCallStack;
		add: 'print oop...' action: [(self promptHex: 'print oop') ifNotNil: [:oop| self printOop: oop]];
		addLine;
		add: 'inspect interpreter' action: #inspect;
		addLine;
		add: 'set break count...' action: [|s| s := UIManager default request: 'break count (dec)'.
											s notEmpty ifTrue: [breakCount := Integer readFrom: s readStream]];
		add: (printSends
				ifTrue: ['no print sends']
				ifFalse: ['print sends'])
			action: [self ensureDebugAtEachStepBlock.
					printSends := printSends not];
		"currently printReturns does nothing"
		"add: (printReturns
				ifTrue: ['no print returns']
				ifFalse: ['print returns'])
			action: [self ensureDebugAtEachStepBlock.
					printReturns := printReturns not];"
		add: (printBytecodeAtEachStep
				ifTrue: ['no print bytecode each bytecode']
				ifFalse: ['print bytecode each bytecode'])
			action: [self ensureDebugAtEachStepBlock.
					printBytecodeAtEachStep := printBytecodeAtEachStep not];
		add: (printContextAtEachStep
				ifTrue: ['no print context each bytecode']
				ifFalse: ['print context each bytecode'])
			action: [self ensureDebugAtEachStepBlock.
					printContextAtEachStep := printBytecodeAtEachStep not].
	^aMenuMorph