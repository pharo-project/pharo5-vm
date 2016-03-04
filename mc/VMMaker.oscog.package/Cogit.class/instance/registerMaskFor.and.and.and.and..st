register management
registerMaskFor: reg1 and: reg2 and: reg3 and: reg4 and: reg5
	<inline: true>
	^(((1 << reg1 bitOr: 1 << reg2) bitOr: 1 << reg3) bitOr: 1 << reg4) bitOr: 1 << reg5