simulation
writeProtectMemory
	<doNotGenerate>
	memory class ~~ ReadOnlyArrayWrapper ifTrue:
		[memory := ReadOnlyArrayWrapper around: memory]