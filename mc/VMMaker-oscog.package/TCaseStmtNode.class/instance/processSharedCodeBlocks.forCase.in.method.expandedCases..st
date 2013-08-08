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
		(node isSend 
		and:[(meth := codeGen methodNamed: node selector) notNil
		and:[meth sharedCase notNil]]) ifTrue:
			[(meth sharedCase = (meth sharedCase isSymbol
									ifTrue: [caseMethod selector]
									ifFalse: [caseIndex])
			  and: [(seen includes: meth sharedLabel) not])
				ifTrue:
					[sharedNode := meth.
					 seen add: meth sharedLabel.
					 map at: node put: (TLabeledCommentNode new setComment: 'goto ', meth sharedLabel)]
				ifFalse:
					[map at: node put: (TGoToNode new setLabel: meth sharedLabel)]]].
	 caseTree replaceNodesIn: map.
	 "recursively expand"
	 sharedNode == nil]
		whileFalse:
			[meth := sharedNode copy.
			 meth hasReturn ifTrue:
				[exitLabel ifNil:
					[exitLabel := aTMethod unusedLabelForInliningInto: aTMethod.
					 aTMethod labels add: exitLabel].
				meth exitVar: nil label: exitLabel].
			meth renameLabelsForInliningInto: aTMethod.
			aTMethod labels addAll: meth labels.
			caseTree setStatements: (caseTree statements copyWith: meth asInlineNode)].
	exitLabel ifNotNil:
		[caseTree setStatements: (caseTree statements copyWith:
			(TLabeledCommentNode new setLabel: exitLabel comment: 'end case'))]