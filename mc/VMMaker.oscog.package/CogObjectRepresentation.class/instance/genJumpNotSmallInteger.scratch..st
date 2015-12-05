compile abstract instructions
genJumpNotSmallInteger: aRegister scratch: scratchReg
	"Generate a test for aRegister containing a SmallInteger and a jump if not, answering the jump.
	 If necessary use scratch reg (since testing for SmallInteger may be destructive)."
	<returnTypeC: #'AbstractInstruction *'>
	| jumpNotInt |
	<inline: true>
	<var: 'jumpNotInt' type: #'AbstractInstruction *'>
	jumpNotInt := self genJumpNotSmallInteger: aRegister.
	jumpNotInt asInteger = UnimplementedOperation ifTrue:
		[cogit MoveR: aRegister R: scratchReg.
		 jumpNotInt := self genJumpNotSmallIntegerInScratchReg: TempReg].
	^jumpNotInt