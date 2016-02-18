spur primitive compilation
accessorDepthForMethod: method
	"Compute the depth the method traverses object structure, assuming it is a primitive.
	 This is in support of Spur's lazy become.  A primitive may fail because it may encounter
	 a forwarder.  The primitive failure code needs to know to what depth it must follow
	  arguments to follow forwarders and, if any are found and followed, retry the primitive.
	 This method determines that depth. It starts by collecting references to the stack and
	 then follows these through assignments to variables and use of accessor methods
	 such as fetchPointer:ofObject:. For example
		| obj field  |
		obj := self stackTop.
		field := objectMemory fetchPointer: 1 ofObject: obj.
		self storePointer: 1 ofObject: field withValue: (self stackValue: 1)
	has depth 2, since field is accessed, and field is an element of obj."

	^((method definingClass includesSelector: method selector) ifTrue:
			[(method definingClass >> method selector) pragmaAt: #accessorDepth:])
		ifNil:
			[((self
					accessorChainsForMethod: method
					interpreterClass: (vmClass ifNil: [StackInterpreter]))
				inject: 0
				into: [:length :chain| length max: (self accessorDepthForChain: chain)]) - 1]
		ifNotNil: [:pragma| pragma arguments first]