bytecode generator support
getActiveContextAllocatesInMachineCode
	"subclasses override if they want, and will have SendNumArgsReg and ClassReg
	 available in addition to ReceiverResultReg and TempReg if they do."
	^false