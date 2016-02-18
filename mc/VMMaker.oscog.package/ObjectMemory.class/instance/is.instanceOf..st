object access
is: oop instanceOf: classOop
	"Answer if oop is an instance of the given class. If the class has a (non-zero)
	 compactClassIndex use that to speed up the check."

	<inline: true>
	(self isIntegerObject: oop) ifTrue:
		[^classOop = (self splObj: ClassSmallInteger)].

	^self isClassOfNonImm: oop equalTo: classOop