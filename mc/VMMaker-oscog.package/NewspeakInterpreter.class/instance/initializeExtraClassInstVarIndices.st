initialization
initializeExtraClassInstVarIndices
	"Initialize metaclassSizeBits and thisClassIndex which are used in debug printing, and
	 classNameIndex which is used not only for debug printing but for is:KindOf: & is:MemberOf:
	 via classNameOf:is: (evil but a reality we have to accept)."
	| classArrayObj classArrayClass |
	classNameIndex := 6. "default"
	thisClassIndex := 5. "default"
	classArrayObj := self splObj: ClassArray.
	classArrayClass := self fetchClassOfNonImm: classArrayObj.
	metaclassSizeBits := self sizeBitsOf: classArrayClass.	"determine actual (Metaclass instSize * 4)"
	InstanceSpecificationIndex + 1 to: (self lengthOf: classArrayClass) do:
		[:i|
		(self fetchPointer: i ofObject: classArrayClass) = classArrayObj ifTrue:
			[thisClassIndex := i]].
	InstanceSpecificationIndex + 1 to: (self lengthOf: classArrayObj) do:
		[:i| | oop |
		oop := self fetchPointer: i ofObject: classArrayObj.
		((self isBytes: oop)
		and: [(self lengthOf: oop) = 5
		and: [(self str: 'Array' n: (self firstFixedField: oop) cmp: 5) = 0]]) ifTrue:
			[classNameIndex := i]]