in-line cacheing
compileCPICEntry
	<returnTypeC: #'AbstractInstruction *'>
	"Compile the cache tag computation and the first comparison.  Answer the address of that comparison."
	entry := objectRepresentation genGetInlineCacheClassTagFrom: ReceiverResultReg into: TempReg forEntry: true.
	self CmpR: ClassReg R: TempReg.
	^self JumpNonZero: 0