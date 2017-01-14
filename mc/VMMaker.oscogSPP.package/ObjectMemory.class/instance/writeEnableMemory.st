simulation
writeEnableMemory
	<doNotGenerate>
	memory class == ReadOnlyArrayWrapper ifTrue:
		[memory := memory array]