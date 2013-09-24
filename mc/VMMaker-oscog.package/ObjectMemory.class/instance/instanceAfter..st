primitive support
instanceAfter: objOop
	"Answer the next instance of objOop's class in the canonical enumeration order,
	 if it exists, otherwise answer nil."
	| classPointer subsequentObject |
	classPointer := self fetchClassOfNonImm: objOop.
	subsequentObject := self objectAfter: objOop.
	[self oop: subsequentObject isLessThan: self freeStart] whileTrue:
		[((self isFreeObject: subsequentObject) not
		  and: [(self fetchClassOfNonImm: subsequentObject) = classPointer]) ifTrue:
			[^subsequentObject].
		 subsequentObject := self objectAfter: subsequentObject].
	^nil