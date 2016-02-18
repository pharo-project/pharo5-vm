object access
isClassOfNonImm: oop equalTo: classOop compactClassIndex: compactClassIndex
	"Answer if the given (non-immediate) object is an instance of the given class
	 that may have a compactClassIndex (if compactClassIndex is non-zero).
	 N.B. Inlining and/or compiler optimization should result in classOop not being
	 accessed if oop's compact class index and compactClassIndex are non-zero.
	 N.B.  Generally one cannot assume that if compactClassIndex is non-zero the
	 instances of the corresponding class always have the compactClassIndex
	 because the compact class index is only non-zero in short header instances."

	| ccIndex |
	<inline: true>
	self assert: (self isIntegerObject: oop) not.

	ccIndex := self compactClassIndexOf: oop.
	ccIndex = 0 ifTrue:
		[^((self classHeader: oop) bitAnd: AllButTypeMask) = classOop].
	compactClassIndex ~= 0 ifTrue:
		[^compactClassIndex = ccIndex].
	^classOop = (self compactClassAt: ccIndex)