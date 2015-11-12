accessing
callerSavedRegisterMask
	"See MIPSConstants initializeRegisters."
	| mask |
	self flag: #OABI.
	mask := 0.
	mask := mask bitOr: 1 << S0.
	mask := mask bitOr: 1 << S1.
	mask := mask bitOr: 1 << S2.
	mask := mask bitOr: 1 << S3.
	mask := mask bitOr: 1 << S4.
	mask := mask bitOr: 1 << S5.
	mask := mask bitOr: 1 << S6.
	mask := mask bitOr: 1 << S7.
	^mask