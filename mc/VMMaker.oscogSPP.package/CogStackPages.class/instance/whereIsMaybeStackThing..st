debug printing
whereIsMaybeStackThing: anOop
	"If anOop is an address within the stack zone answer a string stating that, otherwise answer nil."
	<returnTypeC: 'char *'>
	self subclassResponsibility