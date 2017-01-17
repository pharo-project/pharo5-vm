debug printing
withMemoryProtectionDo: aBlock
	objectMemory writeProtectMemory.
	stackPages writeProtectMemory.
	^aBlock ensure:
		[objectMemory writeEnableMemory.
		 stackPages writeEnableMemory]