compile abstract instructions
genJumpSmallInteger: aRegister scratch: scratchReg
	"Generate a test for aRegister containing a SmallInteger and a jump if so, answering the jump.
	 If necessary use scratch reg (since testing for SmallInteger may be destructive)."
	<returnTypeC: #'AbstractInstruction *'>
	| jumpInt |
	<inline: true>
	<var: 'jumpInt' type: #'AbstractInstruction *'>
	jumpInt := self genJumpSmallInteger: aRegister.
	jumpInt asInteger = UnimplementedOperation ifTrue:
		[cogit MoveR: aRegister R: scratchReg.
		 jumpInt := self genJumpSmallIntegerInScratchReg: TempReg].
	^jumpInt