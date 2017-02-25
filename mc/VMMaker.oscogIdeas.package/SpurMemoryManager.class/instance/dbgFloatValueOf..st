interpreter access
dbgFloatValueOf: oop
	"Answer the C double precision floating point value of the argument,
	 or if it is not, answer 0."

	self subclassResponsibility