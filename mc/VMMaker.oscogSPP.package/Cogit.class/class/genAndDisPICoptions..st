in-image compilation
genAndDisPICoptions: optionsDictionaryOrArray
	"StackToRegisterMappingCogit genAndDisPICoptions: #(ISA ARMv5 CogCompilerClass CogInLineLiteralsARMCompiler)"
	| cogit coInterpreter |
	cogit := self instanceForTests: optionsDictionaryOrArray.
	coInterpreter := CurrentImageCoInterpreterFacade forCogit: cogit.
	[cogit
		setInterpreter: coInterpreter;
		singleStep: true;
		initializeCodeZoneFrom: 1024 upTo: coInterpreter memory size / 2. "leave space for rump C stack"
	 cogit methodZone freeStart: (cogit methodZone freeStart roundUpTo: 1024)]
		on: Notification
		do: [:ex|
			(ex messageText beginsWith: 'cannot find receiver for') ifTrue:
				[ex resume: coInterpreter]].
	cogit disassembleFrom: cogit cPICPrototype + (cogit sizeof: CogMethod) to: cogit cPICPrototype + cogit closedPICSize