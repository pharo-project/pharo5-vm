sista bytecodes
unconditionnalTrapBytecode
	"SistaV1: *	217	Trap"
	SistaVM 
		ifTrue: [^self respondToSistaTrap]
		ifFalse: [^self respondToUnknownBytecode]