abstract instructions
MulCheckOverflowR: reg1 R: reg2
	"Multiplication is a little weird on some processors.  Defer to the backEnd
	 to allow it to generate any special code it may need to."
	<returnTypeC: #'AbstractInstruction *'>
	<inline: false>
	backEnd hasConditionRegister ifTrue:
		[^self MulR: reg1 R: reg2].
	backEnd genCheckOverflowMulR: reg1 R: reg2.
	^self abstractInstructionAt: opcodeIndex - 1