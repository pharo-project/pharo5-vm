object access
is: oop instanceOf: classOop
	"Answer if oop is an instance of the given class."

	<inline: true>
	| tag |
	tag := self fetchClassTagOf: oop.
	^tag = (self rawHashBitsOf: classOop)