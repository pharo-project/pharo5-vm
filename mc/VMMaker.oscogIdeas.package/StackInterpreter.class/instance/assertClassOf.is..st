utilities
assertClassOf: oop is: classOop
	"Succeed if oop is an instance of the given class. Fail if the object is an integer."
	| ok |
	<inline: true>
	ok := objectMemory isNonImmediate: oop.
	ok ifTrue:
		[ok := objectMemory isClassOfNonImm: oop equalTo: classOop].
	self success: ok