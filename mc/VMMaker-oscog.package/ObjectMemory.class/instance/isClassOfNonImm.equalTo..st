header access
isClassOfNonImm: oop equalTo: classOop
	"Answer if the given (non-immediate) object is an instance of the given class."

	| ccIndex cl |
	<inline: true>
	<asmLabel: false>
	(self isIntegerObject: oop) ifTrue:
		[^false].

	cl := (ccIndex := self compactClassIndexOf: oop) = 0
			ifTrue: [(self classHeader: oop) bitAnd: AllButTypeMask]
			ifFalse: [self compactClassAt: ccIndex].
	^cl = classOop