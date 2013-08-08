debug printing
withMemoryProtectionDo: aBlock
	self writeProtectMemory.
	stackPages writeProtectMemory.
	^aBlock ensure:
		[self writeEnableMemory.
		 stackPages writeEnableMemory]