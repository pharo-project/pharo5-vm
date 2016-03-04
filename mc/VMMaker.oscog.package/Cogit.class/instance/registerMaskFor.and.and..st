register management
registerMaskFor: reg1 and: reg2 and: reg3
	^(1 << reg1 bitOr: 1 << reg2) bitOr: 1 << reg3