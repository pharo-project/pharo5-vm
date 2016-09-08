object access
isClassOfNonImm: oop equalTo: classOop compactClassIndex: knownClassIndex
	"Answer if the given (non-immediate) object is an instance of the given class
	 that may have a knownClassIndex (if knownClassIndex is non-zero).  This method
	 is misnamed given SPur's architecture (where all objects have ``compact'' class indices)
	 but is so-named for compatibility with ObjectMemory.
	 N.B. Inlining and/or compiler optimization should result in classOop not being
	 accessed if knownClassIndex is non-zero."

	| ccIndex |
	<inline: true>
	self assert: (self isImmediate: oop) not.

	ccIndex := self classIndexOf: oop.
	knownClassIndex ~= 0
		ifTrue:
			[^knownClassIndex = ccIndex]
		ifFalse:
			[^classOop = (self classAtIndex: ccIndex)]