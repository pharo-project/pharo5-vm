register management
registerMaskFor: reg
	"Answer a bit mask identifying the symbolic register.
	 Registers are negative numbers."
	^1 << (1 - reg)