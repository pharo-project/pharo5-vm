accessing
callerSavedRegisterMask
	"See MIPSConstants initializeRegisters."
	self flag: #OABI.
	^cogit
		registerMaskFor: S0
		and: S1
		and: S2
		and: S3
		and: S4
		and: S5
		and: S6
		and: S7