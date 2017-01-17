interpreter access
floatValueOf: oop
	"Answer the C double precision floating point value of the argument,
	 or fail if it is not a Float, and answer 0.
	 Note: May be called by translated primitive code."

	self subclassResponsibility