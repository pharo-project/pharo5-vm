initialization
initializeExtraClassInstVarIndices
	"Initialize metaclassNumSlots and thisClassIndex which are used in debug printing, and
	 classNameIndex which is used not only for debug printing but for is:KindOf: & is:MemberOf:
	 via classNameOf:is: (evil but a reality we have to accept)."
	| classArrayObj classArrayClass |
	classArrayObj := objectMemory splObj: ClassArray.
	classArrayClass := objectMemory fetchClassOfNonImm: classArrayObj.
	metaclassNumSlots := objectMemory numSlotsOf: classArrayClass.	"determine actual Metaclass instSize"
	thisClassIndex := 5. "default"
	InstanceSpecificationIndex + 1 to: (objectMemory lengthOf: classArrayClass) do:
		[:i|
		(objectMemory fetchPointer: i - 1 ofObject: classArrayClass) = classArrayObj ifTrue:
			[thisClassIndex := i - 1]].
	classNameIndex := 6. "default"
	InstanceSpecificationIndex + 1 to: (objectMemory lengthOf: classArrayObj) do:
		[:i| | oop |
		oop := objectMemory fetchPointer: i - 1 ofObject: classArrayObj.
		((objectMemory isBytes: oop)
		and: [(objectMemory lengthOf: oop) = 5
		and: [(self str: 'Array' n: (objectMemory firstFixedField: oop) cmp: 5) = 0]]) ifTrue:
			[classNameIndex := i - 1]]