inlining
inlineCodeOrNilForStatement: aNode returningNodes: returningNodes in: aCodeGen
	"If the given statement node can be inlined, answer the statements that replace it. Otherwise, answer nil."

	| stmts |
	(aNode isReturn
	 and: [self inlineableSend: aNode expression in: aCodeGen]) ifTrue:
		[stmts := self inlineSend: aNode expression
						directReturn: true exitVar: nil in: aCodeGen.
		stmts last endsWithReturn ifFalse:
			[stmts at: stmts size put: stmts last asReturnNode].
		^stmts].
	(aNode isAssignment
	 and: [self inlineableSend: aNode expression in: aCodeGen]) ifTrue:
		[^self inlineSend: aNode expression
				directReturn: false exitVar: aNode variable name in: aCodeGen].
	(aNode isSend
	 and: [self inlineableSend: aNode in: aCodeGen]) ifTrue:
		[^self inlineSend: aNode
				directReturn: (returningNodes includes: aNode) exitVar: nil in: aCodeGen].
	^nil