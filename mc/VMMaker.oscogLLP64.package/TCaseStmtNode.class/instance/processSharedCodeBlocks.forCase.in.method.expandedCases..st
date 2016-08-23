transformations
processSharedCodeBlocks: caseTree forCase: caseIndex in: codeGen method: aTMethod expandedCases: seen
	"Process any shared code blocks in the case parse tree for the given case, either inlining them or making them a 'goto sharedLabel'."
	| caseMethod map meth sharedNode exitLabel |
	exitLabel := nil.
	"caseTree is expected to be a TStmtListNode whose first element is a comment
	 and whose second element is a TInlineNode for a method."
	caseMethod := caseTree statements second method.
	[sharedNode := nil.
	 map := IdentityDictionary new.
	 caseTree nodesDo:
		[:node|
		(sharedNode isNil
		and: [node isSend 
		and:[(meth := codeGen methodNamed: node selector) notNil
		and:[meth sharedCase notNil]]]) ifTrue:
			[(meth sharedCase = (meth sharedCase isSymbol
									ifTrue: [caseMethod selector]
									ifFalse: [caseIndex])
			  and: [(seen includes: meth sharedLabel) not])
				ifTrue:
					["If the bytecode (the caseMethod) ends with a message that has a lastCase (and lastLabel) then
					  that will be converted into a goto and control will continue to that code,  If the bytecode does
					  /not/ end with a message that has a lastCase (and lastLabel) then control should not continue to
					  that shared case.  expandViaFallThrough captures this, true for the former, false for the latter."
					 | expandViaFallThrough |
					 expandViaFallThrough := false.
					 caseMethod statements last isSend ifTrue:
						[(codeGen methodNamed: caseMethod statements last selector) ifNotNil:
							[:m| expandViaFallThrough := m sharedCase notNil]].
					 seen add: meth sharedLabel.
					 map
						at: node
						put: (expandViaFallThrough
								ifTrue: [sharedNode := meth.
										TLabeledCommentNode new setComment: 'goto ', meth sharedLabel]
								ifFalse: ["Still need recursive expansjon to continue but don't want
										  to duplicate the node, so substitue an empty method."
										 sharedNode := TLabeledCommentNode new setComment: 'null '.
										 meth copy
											renameLabelsForInliningInto: aTMethod;
											addLabelsTo: aTMethod;
											asInlineNode])]
				ifFalse:
					[map at: node put: (TGoToNode new setLabel: meth sharedLabel)]]].
	 caseTree replaceNodesIn: map.
	 "recursively expand"
	 sharedNode notNil]
		whileTrue:
			[sharedNode isTMethod ifTrue:
				[meth := sharedNode copy.
				 meth hasReturn ifTrue:
					[exitLabel ifNil:
						[exitLabel := aTMethod unusedLabelForInliningInto: aTMethod.
						 aTMethod labels add: exitLabel].
					meth exitVar: nil label: exitLabel].
				meth
					renameLabelsForInliningInto: aTMethod;
					addLabelsTo: aTMethod.
				caseTree setStatements: (caseTree statements copyWith: meth asInlineNode)]].
	exitLabel ifNotNil:
		[caseTree setStatements: (caseTree statements copyWith:
			(TLabeledCommentNode new setLabel: exitLabel comment: 'end case'))]