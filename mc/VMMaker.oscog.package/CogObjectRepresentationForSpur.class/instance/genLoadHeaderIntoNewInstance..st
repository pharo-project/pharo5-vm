initialization
genLoadHeaderIntoNewInstance: header
	"Generate the instructions to move the constant header into a new instance pointed to by ReceiverResultReg."
	^self subclassResponsibility