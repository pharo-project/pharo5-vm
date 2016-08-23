gc - global
markLoopFrom: objOop
	"Scan objOop and all objects on the mark stack, until the mark stack is empty.
	 N.B. When the incremental GC is written this will probably be refactored as
	 markLoopFrom: objOop while: aBlock"
	<inline: true>
	| objToScan field index numStrongSlots scanLargeObject |

	"Now scan the object, and any remaining objects on the mark stack."
	objToScan := objOop.
	"To avoid overflowing the mark stack when we encounter large objects, we
	 push the obj, then its numStrongSlots, and then index the object from the stack."
	[(self isImmediate: objToScan)
		ifTrue: [scanLargeObject := true]
		ifFalse:
			[numStrongSlots := self numStrongSlotsOfInephemeral: objToScan.
			 scanLargeObject := numStrongSlots > self traceImmediatelySlotLimit].
	 scanLargeObject
		ifTrue: "scanning a large object. scan until hitting an unmarked object, then switch to it, if any."
			[(self isImmediate: objToScan)
				ifTrue:
					[index := self integerValueOf: objToScan.
					 objToScan := self topOfObjStack: markStack]
				ifFalse:
					[index := numStrongSlots.
					 self markAndTraceClassOf: objToScan].
			 [index > 0] whileTrue:
				[index := index - 1.
				 field := self fetchPointer: index ofObject: objToScan.
				 (self isNonImmediate: field) ifTrue:
					[(self isForwarded: field) ifTrue: "fixFollowedField: is /not/ inlined"
						[field := self fixFollowedField: index ofObject: objToScan withInitialValue: field].
					 (self markAndShouldScan: field) ifTrue:
						[index > 0 ifTrue:
							[(self topOfObjStack: markStack) ~= objToScan ifTrue: 
								[self push: objToScan onObjStack: markStack].
							 self push: (self integerObjectOf: index) onObjStack: markStack].
						 objToScan := field.
						 index := -1]]].
			 index >= 0 ifTrue: "if loop terminated without finding an unmarked referent, switch to top of stack."
				[objToScan := self popObjStack: markStack.
				 objToScan = objOop ifTrue:
					[objToScan := self popObjStack: markStack]]]
		ifFalse: "scanning a small object. scan, marking, pushing unmarked referents, then switch to the top of the stack."
			[index := numStrongSlots.
			 self markAndTraceClassOf: objToScan.
			 [index > 0] whileTrue:
				[index := index - 1.
				 field := self fetchPointer: index ofObject: objToScan.
				 (self isNonImmediate: field) ifTrue:
					[(self isForwarded: field) ifTrue: "fixFollowedField: is /not/ inlined"
						[field := self fixFollowedField: index ofObject: objToScan withInitialValue: field].
					 (self markAndShouldScan: field) ifTrue:
						[self push: field onObjStack: markStack.
						 ((self rawNumSlotsOf: field) > self traceImmediatelySlotLimit
						  and: [(numStrongSlots := self numStrongSlotsOfInephemeral: field) > self traceImmediatelySlotLimit]) ifTrue:
							[self push: (self integerObjectOf: numStrongSlots) onObjStack: markStack]]]].
			 objToScan := self popObjStack: markStack].
	 objToScan notNil] whileTrue