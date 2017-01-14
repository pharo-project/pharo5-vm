initialization
initializeCodeZoneFrom: startAddress upTo: endAddress
	scratchSimStack := self cCode: [self malloc: self simStackSlots * (self sizeof: CogSimStackEntry)]
							inSmalltalk: [CArrayAccessor on: ((1 to: self simStackSlots) collect: [:ign| CogRegisterAllocatingSimStackEntry new])].
	super initializeCodeZoneFrom: startAddress upTo: endAddress