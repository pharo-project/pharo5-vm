inlining
inlineGuardingConditional: aSendNode in: aCodeGen
	"Inline
		aSend ifTrue:/ifFalse: [statements]
	 where aSend is inlineable and always answers booleans.  We convert
	 the boolean returns in aSend to jumps."
	| evaluateIfTrue replacementTree map lastNode evaluateLabel skipLabel method |
	self assert: self == aCodeGen currentMethod.
	self assert: (self isInlineableConditional: aSendNode in: aCodeGen).
	aCodeGen maybeBreakForInlineOf: aSendNode in: self.
	evaluateIfTrue := aSendNode selector = #ifTrue:.
	method := (aCodeGen methodNamed: aSendNode receiver selector) copy.
	replacementTree := method inlineFunctionCall: aSendNode receiver in: aCodeGen.
	map := Dictionary new.
	(replacementTree statements last isReturn
	 and: [replacementTree statements last expression value = evaluateIfTrue]) ifTrue:
		[lastNode := replacementTree statements last].
	skipLabel := TLabeledCommentNode new setLabel:
					(self unusedLabelForInlining: method).
	replacementTree nodesDo:
		[:node| | expr |
		 node isReturn ifTrue:
			[expr := node expression.
			 self assert: (expr isConstant and: [#(true false) includes: expr value]).
			 map
				at: node
				put: (expr value ~~ evaluateIfTrue
						ifTrue: [TGoToNode new setLabel: skipLabel label]
						ifFalse:
							[node == lastNode
								ifTrue: [TLabeledCommentNode new setComment: 'end ', aSendNode receiver selector, '; fall through']
								ifFalse:
									[evaluateLabel ifNil:
										[evaluateLabel := TLabeledCommentNode new setLabel:
													(self unusedLabelForInlining: method)].
									 TGoToNode new setLabel: evaluateLabel label]])]].
	replacementTree replaceNodesIn: map.
	replacementTree comment: {'inline ', aSendNode receiver selector}.
	self addVarsDeclarationsAndLabelsOf: method except: method args.
	^TStmtListNode new
		setArguments: #()
		statements:
			(evaluateLabel
				ifNil: [replacementTree statements, aSendNode args first statements, {skipLabel}]
				ifNotNil:
					[replacementTree statements, {evaluateLabel}, aSendNode args first statements, {skipLabel}])