generate machine code
concretizeAt: actualAddress
	"Override to check maxSize and machineCodeSize"

	| result |
	maxSize ifNil: [maxSize := self computeMaximumSize].
	result := super concretizeAt: actualAddress.
	self assert: (maxSize notNil
				and: [self isPCDependent
						ifTrue: [maxSize >= machineCodeSize]
						ifFalse: [maxSize = machineCodeSize]]).
	^result