object access
fetchClassOfNonImm: objOop
	<inline: #never>
	| classIndex |
	classIndex := self classIndexOf: objOop.
	classIndex <= self classIsItselfClassIndexPun ifTrue:
		[classIndex = self classIsItselfClassIndexPun ifTrue:
			[^objOop].
		 "Answer nil to avoid the assert failure in classOrNilAtIndex:"
		 classIndex = self isForwardedObjectClassIndexPun ifTrue:
			[^nilObj]].
	self assert: classIndex >= self arrayClassIndexPun.
	^self classOrNilAtIndex: classIndex