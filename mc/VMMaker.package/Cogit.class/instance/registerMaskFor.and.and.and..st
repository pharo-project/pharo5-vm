register management
registerMaskFor: reg1 and: reg2 and: reg3 and: reg4
	"Answer a bit mask identifying the symbolic registers.
	 Registers are negative numbers."
	^((1 << (1 - reg1) bitOr: 1 << (1 - reg2)) bitOr: 1 << (1 - reg3)) bitOr: 1 << (1 - reg4)