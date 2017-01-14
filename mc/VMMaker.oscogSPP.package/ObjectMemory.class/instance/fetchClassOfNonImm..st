object access
fetchClassOfNonImm: oop 
	| ccIndex |
	<inline: true>
	^(ccIndex := (self compactClassIndexOf: oop)) = 0
		ifTrue: [(self classHeader: oop) bitAnd: AllButTypeMask]
		ifFalse: [self compactClassAt: ccIndex]