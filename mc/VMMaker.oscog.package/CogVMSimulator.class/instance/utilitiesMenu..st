UI
utilitiesMenu: aMenuMorph
	aMenuMorph
		add: 'toggle transcript' action: #toggleTranscript;
		add: 'clone VM' action: #cloneSimulationWindow;
		addLine;
		add: 'print ext head frame' action: #printExternalHeadFrame;
		add: 'print int head frame' action: #printHeadFrame;
		add: 'print mc/cog frame' action: [self printFrame: cogit processor fp WithSP: cogit processor sp];
		add: 'short print ext frame & callers' action: [self shortPrintFrameAndCallers: framePointer];
		add: 'short print int frame & callers' action: [self shortPrintFrameAndCallers: localFP];
		add: 'short print mc/cog frame & callers' action: [self shortPrintFrameAndCallers: cogit processor fp];
		add: 'long print ext frame & callers' action: [self printFrameAndCallers: framePointer SP: stackPointer];
		add: 'long print int frame & callers' action: [self printFrameAndCallers: localFP SP: localSP];
		add: 'long print mc/cog frame & callers' action: [self printFrameAndCallers: cogit processor fp SP: cogit processor sp];
		add: 'print frame...' action: [(self promptHex: 'print frame') ifNotNil: [:fp| self printFrame: fp]];
		add: 'print call stack' action: #printCallStack;
		add: 'print stack call stack' action: #printStackCallStack;
		add: 'print stack call stack of...' action: [(self promptHex: 'frame') ifNotNil: [:fp| self printStackCallStackOf: fp]];
		add: 'print call stack of...' action: [(self promptHex: 'context or process oop') ifNotNil: [:obj| self printCallStackOf: obj]];
		add: 'print call stack of frame...' action: [(self promptHex: 'frame') ifNotNil: [:fp| self printCallStackFP: fp]];
		add: 'print all stacks' action: #printAllStacks;
		add: 'write back local ptrs' action: [stackPointer := localSP. framePointer := localFP. instructionPointer := localIP.
											self writeBackHeadFramePointers];
		add: 'write back mc ptrs' action: [stackPointer := cogit processor sp. framePointer := cogit processor fp. instructionPointer := cogit processor eip.
											self writeBackHeadFramePointers];
		addLine;
		add: 'print registers' action: [cogit processor printRegistersOn: transcript];
		add: 'print register map' action: [cogit printRegisterMapOn: transcript];
		add: 'disassemble method/trampoline...' action: [(self promptHex: 'pc') ifNotNil: [:pc| cogit disassembleCodeAt: pc]];
		add: 'disassemble method/trampoline at pc' action: [cogit disassembleCodeAt: cogit processor pc];
		add: 'disassemble ext head frame method' action: [cogit disassembleMethod: (self frameMethod: framePointer)];
		add: 'print oop...' action: [(self promptHex: 'print oop') ifNotNil: [:oop| self printOop: oop]];
		add: 'long print oop...' action: [(self promptHex: 'print oop') ifNotNil: [:oop| self longPrintOop: oop]];
		add: 'print context...' action: [(self promptHex: 'print context') ifNotNil: [:oop| self printContext: oop]];
		addLine;
		add: 'inspect object memory' target: objectMemory action: #inspect;
		add: 'inspect cointerpreter' action: #inspect;
		add: 'inspect cogit' target: cogit action: #inspect;
		add: 'inspect method zone' target: cogit methodZone action: #inspect.
	self isThreadedVM ifTrue:
		[aMenuMorph add: 'inspect thread manager' target: self threadManager action: #inspect].
	aMenuMorph
		addLine;
		add: 'print cog methods' target: cogMethodZone action: #printCogMethods;
		add: 'print cog methods with prim...' action: [(self promptNum: 'prim index') ifNotNil: [:pix| cogMethodZone printCogMethodsWithPrimitive: pix]];
		add: 'print trampoline table' target: cogit action: #printTrampolineTable;
		add: 'print prim trace log' action: #dumpPrimTraceLog;
		add: 'report recent instructions' target: cogit action: #reportLastNInstructions;
		add: 'set break pc (', (cogit breakPC isInteger ifTrue: [cogit breakPC hex] ifFalse: [cogit breakPC printString]), ')...' action: [(self promptHex: 'break pc') ifNotNil: [:bpc| cogit breakPC: bpc]];
		add: (cogit singleStep
				ifTrue: ['no single step']
				ifFalse: ['single step'])
			action: [cogit singleStep: cogit singleStep not];
		add: (cogit printRegisters
				ifTrue: ['no print registers each instruction']
				ifFalse: ['print registers each instruction'])
			action: [cogit printRegisters: cogit printRegisters not];
		add: (cogit printInstructions
				ifTrue: ['no print instructions each instruction']
				ifFalse: ['print instructions each instruction'])
			action: [cogit printInstructions: cogit printInstructions not];
		addLine;
		add: 'set break count...' action: [|s| s := UIManager default request: 'break count (dec)'.
											s notEmpty ifTrue: [breakCount := Integer readFrom: s readStream]];
		add: 'set break selector...' action: [|s| s := UIManager default request: 'break selector'.
											s notEmpty ifTrue: [self setBreakSelector: s]];
		add: 'set break block...' action: [|s| s := UIManager default request: 'break block' initialAnswer: '[:theCogit| false]'.
											s notEmpty ifTrue: [self setBreakBlockFromString: s]];
		add: 'set cogit break method...' action: [(self promptHex: 'cogit breakMethod') ifNotNil: [:bm| cogit setBreakMethod: bm]];
		add: (printBytecodeAtEachStep
				ifTrue: ['no print bytecode each bytecode']
				ifFalse: ['print bytecode each bytecode'])
			action: [self ensureDebugAtEachStepBlock.
					printBytecodeAtEachStep := printBytecodeAtEachStep not];
		add: (printFrameAtEachStep
				ifTrue: ['no print frame each bytecode']
				ifFalse: ['print frame each bytecode'])
			action: [self ensureDebugAtEachStepBlock.
					printFrameAtEachStep := printFrameAtEachStep not].
	^aMenuMorph