spur primitive compilation
accessorChainsForMethod: method interpreterClass: interpreterClass
	"Answer a set of access paths from arguments through objects, in the method, assuming
	 it is a primitive. This is in support of Spur's lazy become.  A primitive may fail because it
	 may encounter a forwarder.  The primitive failure code needs to know to what depth it
	 must follow arguments to follow forwarders and, if any are found and followed, retry the
	 primitive. This method determines that depth. It starts by collecting references to the
	 stack and then follows these through assignments to variables and use of accessor
	 methods such as fetchPointer:ofObject:. For example
		| obj field  |
		obj := self stackTop.
		field := objectMemory fetchPointer: 1 ofObject: obj.
		self storePointer: 1 ofObject: field withValue: (self stackValue: 1)
	has depth 2, since field is accessed, and field is an element of obj."

	| accessors assignments roots chains extendedChains extended lastPass |
	self accessorsAndAssignmentsForMethod: method
		actuals: (self actualsForMethod: method)
		depth: 0
		interpreterClass: interpreterClass
		into: [:theRoots :theAccessors :theAssignments|
			roots := theRoots.
			accessors := theAccessors.
			assignments := theAssignments].
	"Compute the transitive closure of assignments of accessor sends or variables to variables from the roots.
	 Start from the stack accesses (the roots).
	 On the last pass look only for accessors of the targets of the tip assignments."
	chains := OrderedCollection new.
	roots do: [:root| chains addAll: (assignments
									select: [:assignment| assignment expression = root]
									thenCollect: [:assignment| OrderedCollection with: assignment])].
	lastPass := false.
	[extended := false.
	 extendedChains := OrderedCollection new: chains size * 2.
	 chains do:
		[:chain| | tip refs accessorRefs variableRefs |
		tip := chain last variable.
		refs := accessors select: [:send| send args anySatisfy: [:arg| tip isSameAs: arg]].
		lastPass ifFalse:
			[accessorRefs := refs collect: [:send|
											assignments
												detect: [:assignment|
														assignment expression = send
														and: [(chain includes: assignment) not]]
												ifNone: []]
									thenSelect: [:assignmentOrNil| assignmentOrNil notNil].
			 variableRefs := assignments select:
								[:assignment|
								 (tip isSameAs: assignment expression)
								 and: [(tip isSameAs: assignment variable) not
								 and: [(chain includes: assignment) not]]].
			 refs := (Set withAll: accessorRefs) addAll: variableRefs; yourself].
		refs isEmpty
			ifTrue:
				[extendedChains add: chain]
			ifFalse:
				[lastPass ifFalse: [extended := true].
				 self assert: (refs noneSatisfy: [:assignment| chain includes: assignment]).
				 extendedChains addAll: (refs collect: [:assignment| chain, {assignment}])]].
	 extended or: [lastPass not]] whileTrue:
		[chains := extendedChains.
		 extended ifFalse: [lastPass := true]].
	^chains