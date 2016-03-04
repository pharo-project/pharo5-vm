register management
registerMaskFor: reg1 and: reg2 and: reg3 and: reg4 and: reg5 and: reg6 and: reg7 and: reg8 and: reg9
	<inline: true>
	^(((((((1 << reg1 bitOr: 1 << reg2) bitOr: 1 << reg3) bitOr: 1 << reg4) bitOr: 1 << reg5) bitOr: 1 << reg6) bitOr: 1 << reg7) bitOr: 1 << reg8) bitOr: 1 << reg9