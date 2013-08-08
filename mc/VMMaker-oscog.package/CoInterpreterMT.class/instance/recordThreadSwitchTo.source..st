debug support
recordThreadSwitchTo: ownerIndex source: sourceCode
	cogit recordEventTrace ifTrue:
		[self recordTrace: TraceThreadSwitch
			thing: (objectMemory integerObjectOf: (ownerIndex << 16) + cogThreadManager getVMOwner)
			source: sourceCode]