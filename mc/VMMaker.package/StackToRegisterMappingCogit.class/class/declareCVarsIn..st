translation
declareCVarsIn: aCodeGen
	aCodeGen
		var: #methodAbortTrampolines
			declareC: 'sqInt methodAbortTrampolines[4]';
		var: #picAbortTrampolines
			declareC: 'sqInt picAbortTrampolines[4]';
		var: #picMissTrampolines
			declareC: 'sqInt picMissTrampolines[4]';
		var: 'ceEnter0ArgsPIC'
			declareC: 'void (*ceEnter0ArgsPIC)(void)';
		var: 'ceEnter1ArgsPIC'
			declareC: 'void (*ceEnter1ArgsPIC)(void)';
		var: 'ceEnter2ArgsPIC'
			declareC: 'void (*ceEnter2ArgsPIC)(void)';
		var: #ceEnterCogCodePopReceiverArg0Regs
			declareC: 'void (*ceEnterCogCodePopReceiverArg0Regs)(void)';
		var: #realCEEnterCogCodePopReceiverArg0Regs
			declareC: 'void (*realCEEnterCogCodePopReceiverArg0Regs)(void)';
		var: #ceEnterCogCodePopReceiverArg1Arg0Regs
			declareC: 'void (*ceEnterCogCodePopReceiverArg1Arg0Regs)(void)';
		var: #realCEEnterCogCodePopReceiverArg1Arg0Regs
			declareC: 'void (*realCEEnterCogCodePopReceiverArg1Arg0Regs)(void)';
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