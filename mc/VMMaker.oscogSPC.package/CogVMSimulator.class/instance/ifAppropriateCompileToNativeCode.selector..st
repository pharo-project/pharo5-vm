debugging traps
ifAppropriateCompileToNativeCode: aMethodObject selector: selector
	enableCog ifTrue:
		[super ifAppropriateCompileToNativeCode: aMethodObject selector: selector]