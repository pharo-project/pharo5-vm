compile abstract instructions
genJumpIsSmallIntegerValue: aRegister scratch: scratchReg
	"Generate a test for aRegister containing an integer value in the SmallInteger range, and a jump if so, answering the jump."
	<returnTypeC: #'AbstractInstruction *'>
	self subclassResponsibility