in-line cacheing
compileCPICEntry
	<returnTypeC: #'AbstractInstruction *'>
	"Compile the cache tag computation and the first comparison.  Answer the address of that comparison."
	self AlignmentNops: (BytesPerWord max: 8).
	entry := self Label.
	objectRepresentation getInlineCacheClassTagFrom: ReceiverResultReg into: TempReg.
	self CmpR: ClassReg R: TempReg.
	^self JumpNonZero: 0