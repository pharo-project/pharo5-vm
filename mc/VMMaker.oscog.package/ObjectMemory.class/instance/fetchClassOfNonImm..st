interpreter access
fetchClassOfNonImm: oop 
	| ccIndex |
	<inline: true>
	<asmLabel: false>
	^(ccIndex := (self compactClassIndexOf: oop)) = 0
		ifTrue: [(self classHeader: oop) bitAnd: AllButTypeMask]
		ifFalse: [self compactClassAt: ccIndex]