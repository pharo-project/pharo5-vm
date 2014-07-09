translation
declareCVarsIn: aCodeGen
	aCodeGen
		var: #methodAbortTrampolines
			declareC: 'sqInt methodAbortTrampolines[4]';
		var: #picAbortTrampolines
			declareC: 'sqInt picAbortTrampolines[4]';
		var: #picMissTrampolines
			declareC: 'sqInt picMissTrampolines[4]';
		var: 'ceCall0ArgsPIC'
			declareC: 'void (*ceCall0ArgsPIC)(void)';
		var: 'ceCall1ArgsPIC'
			declareC: 'void (*ceCall1ArgsPIC)(void)';
		var: 'ceCall2ArgsPIC'
			declareC: 'void (*ceCall2ArgsPIC)(void)';
		var: #ceCallCogCodePopReceiverArg0Regs
			declareC: 'void (*ceCallCogCodePopReceiverArg0Regs)(void)';
		var: #realCECallCogCodePopReceiverArg0Regs
			declareC: 'void (*realCECallCogCodePopReceiverArg0Regs)(void)';
		var: #ceCallCogCodePopReceiverArg1Arg0Regs
			declareC: 'void (*ceCallCogCodePopReceiverArg1Arg0Regs)(void)';
		var: #realCECallCogCodePopReceiverArg1Arg0Regs
			declareC: 'void (*realCECallCogCodePopReceiverArg1Arg0Regs)(void)';
		var: 'simStack'
			declareC: 'CogSimStackEntry simStack[', ((CoInterpreter bindingOf: #LargeContextSize) value * 5 / 4 // BytesPerWord) asString, ']';
		var: 'simSelf'
			type: #CogSimStackEntry;
		var: #optStatus
			type: #CogSSOptStatus;
		var: 'prevBCDescriptor'
			type: #'BytecodeDescriptor *'.

	self isPushNilFunction ifNotNil:
		[aCodeGen
			var: 'isPushNilFunction'
				declareC: 'sqInt (* const isPushNilFunction)(struct _BytecodeDescriptor *,sqInt,sqInt,sqInt) = ', (aCodeGen cFunctionNameFor: self isPushNilFunction);
			var: 'pushNilSizeFunction'
				declareC: 'sqInt (* const pushNilSizeFunction)(sqInt) = ', (aCodeGen cFunctionNameFor: self pushNilSizeFunction)].

	aCodeGen
		addSelectorTranslation: #register to: (aCodeGen cFunctionNameFor: 'registerr');
		addSelectorTranslation: #register: to: (aCodeGen cFunctionNameFor: 'registerr:')