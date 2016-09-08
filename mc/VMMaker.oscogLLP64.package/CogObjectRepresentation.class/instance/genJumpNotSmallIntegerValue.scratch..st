compile abstract instructions
genJumpNotSmallIntegerValue: aRegister scratch: scratchReg
	"Generate a test for aRegister containing an integer value outside the SmallInteger range, and a jump if so, answering the jump."
	<returnTypeC: #'AbstractInstruction *'>
	self subclassResponsibility