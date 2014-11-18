utilities
assertClassOf: oop is: classOop
	"Succeed if the given (non-integer) object is an instance of the given class. Fail if the object is an integer."

	<inline: true>
	self success: (self isClassOfNonImm: oop equalTo: classOop)