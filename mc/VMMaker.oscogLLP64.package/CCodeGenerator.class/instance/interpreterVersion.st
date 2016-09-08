accessing
interpreterVersion
	^self vmClass interpreterVersion, '[', self vmClass objectMemoryClass memoryManagerVersion, ']'