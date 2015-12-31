accessing
callerSavedRegisterMask
	"Volatile"
	"See MIPSConstants initializeRegisters."
	self flag: #OABI.
	^cogit
		registerMaskFor: T0
		and: T1
		and: T2
		and: T3
		and: T4
		and: T5
		and: T6
		and: T7
		and: T8
		and: T9