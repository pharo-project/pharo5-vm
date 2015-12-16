abstract instructions
genMulR: regSource R: regDest
	"Generate whatever code necessary to do a bytesPerOop x bytesPerOop multiplication,
	 answering the first instruction uin the sequence."
	<returnTypeC: #'AbstractInstruction *'>
	self subclassResponsibility