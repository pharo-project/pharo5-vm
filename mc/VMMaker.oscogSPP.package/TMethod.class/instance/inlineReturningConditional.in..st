inlining
inlineReturningConditional: aSendNode in: aCodeGen
	"Inline
		aSend ifTrue:/ifFalse: [^expr]
	 where aSend is inlineable and always answers booleans.  We inline ^expr
	 into aSend."
	| returnIfTrue returnNode replacementTree map lastNode label method |
	self assert: self == aCodeGen currentMethod.
	self assert: (self isInlineableConditional: aSendNode in: aCodeGen).
	aCodeGen maybeBreakForInlineOf: aSendNode receiver in: self.
	returnIfTrue := aSendNode selector = #ifTrue:.
	returnNode := aSendNode args first.
	method := (aCodeGen methodNamed: aSendNode receiver selector) copy.
	replacementTree := method inlineFunctionCall: aSendNode receiver in: aCodeGen.
	map := Dictionary new.
	(replacementTree statements last isReturn
	 and: [replacementTree statements last expression value = returnIfTrue not]) ifTrue:
		[lastNode := replacementTree statements last].
	replacementTree nodesDo:
		[:node| | expr |
		 node isReturn ifTrue:
			[expr := node expression.
			 self assert: (expr isConstant and: [#(true false) includes: expr value]).
			 map
				at: node
				put: (expr value == returnIfTrue
						ifTrue: [returnNode]
						ifFalse:
							[node == lastNode
								ifTrue: [TLabeledCommentNode new setComment: 'end ', aSendNode receiver selector, '; fall through']
								ifFalse:
									[label ifNil:
										[label := TLabeledCommentNode new setLabel:
													(self unusedLabelForInlining: method)].
									 TGoToNode new setLabel: label label]])]].
	replacementTree replaceNodesIn: map.
	self addVarsDeclarationsAndLabelsOf: method except: method args.
	replacementTree comment: {'inline ', aSendNode receiver selector}.
	^label
		ifNil: [replacementTree]
		ifNotNil:
			[TStmtListNode new
				setArguments: #()
				statements: {replacementTree. label}]