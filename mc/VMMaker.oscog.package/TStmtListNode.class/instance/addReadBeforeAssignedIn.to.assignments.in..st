utilities
addReadBeforeAssignedIn: variables to: readBeforeAssigned assignments: assigned in: aCodeGen
	"Add any variables in variables that are read before written to readBeforeAssigned.
	 Add unconditional assignments to assigned.  For convenience answer assigned."
	self
		nodesWithParentsDo:
			[:node :parent|
			(node isAssignment
			 and: [variables includes: node variable name]) ifTrue:
				[assigned add: node variable name].
			(node isVariable
			 and: [(variables includes: node name)
			 and: [(assigned includes: node name) not
			 and: [(node structTargetKindIn: aCodeGen) isNil
			 and: [(parent notNil and: [parent isAssignment and: [parent variable == node]]) not]]]]) ifTrue:
				[node name = 'theCalloutState' ifTrue:
					[self halt].
				 readBeforeAssigned add: node name]]
		unless:
			[:node :parent| | conditionalAssignments mayHaveSideEffects |
			node isSend
				ifTrue:
					["First deal with implicit assignments..."
					node isValueExpansion ifTrue:
						[assigned addAll: node receiver args].
					(#(mem:cp:y: mem:mo:ve:) includes: node selector) ifTrue:
						[assigned add: (node args first detect: [:subnode| subnode isVariable]) name].
					(#(to:do: to:by:do:) includes: node selector) ifTrue:
						[assigned addAll: (node args at: node selector numArgs) args.
						 mayHaveSideEffects := node args size = 4. "See TMethod>>prepareMethodIn:"
						 mayHaveSideEffects ifTrue:
							[assigned add: node args last name]].
					"Then deal with read-before-written in the arms of conditionals..."
					(#(ifTrue: ifFalse: ifNil: ifNotNil:) intersection: node selector keywords) notEmpty
						ifTrue:
							["First find assignments in the expression..."
							 (TStmtListNode new setStatements: {node receiver}; yourself)
								addReadBeforeAssignedIn: variables
								to: readBeforeAssigned
								assignments: assigned
								in: aCodeGen.
							 "Now find read-before-written in each arm, and collect the assignments to spot those assigned in both arms"
							 conditionalAssignments :=
								node args
									collect:
										[:block|
										block isStmtList ifTrue:
											[block
												addReadBeforeAssignedIn: variables
												to: readBeforeAssigned
												assignments: assigned copy
												in: aCodeGen]]
									thenSelect: [:each| each notNil].
							 "add to assigned those variables written to in both arms"
							 conditionalAssignments size = 2 ifTrue:
								[conditionalAssignments := conditionalAssignments collect: [:set| set difference: assigned].
								 assigned addAll: (conditionalAssignments first intersection: conditionalAssignments last)].
							 true]
						ifFalse:
							[false]]
				ifFalse:
					[false]].
	^assigned