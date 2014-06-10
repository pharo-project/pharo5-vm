object access
fetchClassOfNonImm: objOop
	| classIndex |
	classIndex := self classIndexOf: objOop.
	classIndex = self classIsItselfClassIndexPun ifTrue:
		[^objOop].
	self assert: classIndex >= self arrayClassIndexPun.
	^self classOrNilAtIndex: classIndex