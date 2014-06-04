generate machine code
concretizeFill16
	"fill with (operand 0 bitAnd: 16rFFFF) according to the processor's endianness"
	self subclassResponsibility