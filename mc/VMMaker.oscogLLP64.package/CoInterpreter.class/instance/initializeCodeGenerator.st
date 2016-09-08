initialization
initializeCodeGenerator
	cogit
		initializeCodeZoneFrom: (self cCode: [objectMemory memory] inSmalltalk: [Cogit guardPageSize])
		upTo: (self cCode: [objectMemory memory] inSmalltalk: [Cogit guardPageSize]) + cogCodeSize