in-line cacheing
compileCPICEntry
	<returnTypeC: #'AbstractInstruction *'>
	"Compile the cache tag computation and the first comparison.  Answer the address of that comparison."
	self cppIf: NewspeakVM ifTrue:
		[self Nop. "1st nop differentiates dynSuperEntry from no-check entry if using nextMethod"
		 dynSuperEntry := self Nop].
	entry := objectRepresentation getInlineCacheClassTagFrom: ReceiverResultReg into: TempReg.
	self CmpR: ClassReg R: TempReg.
	^self JumpNonZero: 0