utilities
assertClassOf: oop is: classOop
	"Succeed if oop is an instance of the given class. Fail if the object is an integer."

	<inline: true>
	<asmLabel: false>
	self success: (objectMemory isClassOfNonImm: oop equalTo: classOop)