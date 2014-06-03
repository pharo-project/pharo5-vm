gc - global
markAndTrace: objOop
	"Mark the argument, and all objects reachable from it, and any remaining objects
	 on the mark stack. Follow forwarding pointers in the scan."
	<api>
	| objToScan numStrongSlots index field |
	(self markAndShouldScan: objOop) ifFalse:
		[^self].
	"if markAndTrace: is to follow and eliminate forwarding pointers
	 in its scan it cannot be handed an r-value which is forwarded."
	self assert: (self isForwarded: objOop) not.

	"Now scan the object, and any remaining objects on the mark stack."
	objToScan := objOop.
	"To avoid overflowing the mark stack when we encounter large objects, we
	 push the obj, then its numStrongSlots, and then index the object from the stack."
	[((self isImmediate: objToScan)
	  or: [numStrongSlots := self numStrongSlotsOf: objToScan ephemeronInactiveIf: #inactiveOrFailedToDeferScan:.
		 numStrongSlots > self traceImmediatelySlotLimit])
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
				 (self isOopForwarded: field) ifTrue:
					[field := self followForwarded: field.
					 self storePointer: index ofObject: objToScan withValue: field].
				 (self markAndShouldScan: field) ifTrue:
					[index > 0 ifTrue:
						[(self topOfObjStack: markStack) ~= objToScan ifTrue: 
							[self push: objToScan onObjStack: markStack].
						 self push: (self integerObjectOf: index) onObjStack: markStack].
					 objToScan := field.
					 index := -1]].
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
				 (self isOopForwarded: field) ifTrue:
					[field := self followForwarded: field.
					 self storePointer: index ofObject: objToScan withValue: field].
				 (self markAndShouldScan: field) ifTrue:
					[self push: field onObjStack: markStack.
					 numStrongSlots := self numStrongSlotsOf: field ephemeronInactiveIf: #inactiveOrFailedToDeferScan:.
					 numStrongSlots > self traceImmediatelySlotLimit ifTrue:
						[self push: (self integerObjectOf: numStrongSlots) onObjStack: markStack]]].
			 objToScan := self popObjStack: markStack].
	 objToScan notNil] whileTrue