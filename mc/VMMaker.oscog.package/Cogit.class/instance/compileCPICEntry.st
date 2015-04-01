in-line cacheing
compileCPICEntry
	<returnTypeC: #'AbstractInstruction *'>
	"Compile the cache tag computation and the first comparison.  Answer the address of that comparison."
	self cppIf: NewspeakVM ifTrue:
		[self Nop. "1st nop differentiates from no-check entry if using nextMethod"
		 selfSendEntry := self Nop.
		 dynSuperEntry := self Nop].
	entry := objectRepresentation genGetInlineCacheClassTagFrom: ReceiverResultReg into: TempReg forEntry: true.
	self CmpR: ClassReg R: TempReg.
	^self JumpNonZero: 0