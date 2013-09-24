allocation
checkForLastObjectOverwrite
	<doNotGenerate>
	self assert: (freeStart >= scavengeThreshold
				or: [CheckObjectOverwrite not
		  		or: [(self longAt: freeStart) = freeStart]])