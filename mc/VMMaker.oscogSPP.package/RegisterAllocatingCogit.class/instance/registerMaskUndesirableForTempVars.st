bytecode generator support
registerMaskUndesirableForTempVars
	"Answer the mask containing registers to avoid for temporary variables."
	<inline: true>
	^self registerMaskFor: ReceiverResultReg and: ClassReg and: SendNumArgsReg and: TempReg