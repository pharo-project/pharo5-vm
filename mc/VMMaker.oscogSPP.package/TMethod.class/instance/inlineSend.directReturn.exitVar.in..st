inlining
inlineSend: aSendNode directReturn: directReturn exitVar: exitVar in: aCodeGen
	"Answer a collection of statements to replace the given send.  directReturn indicates
	 that the send is the expression in a return statement, so returns can be left in the
	 body of the inlined method. If exitVar is nil, the value returned by the send is not
	 used; thus, returns need not assign to the output variable.

	 Types are propagated to as-yet-untyped variables when inlining a send that is assigned,
	 otherwise the assignee variable type must match the return type of the inlinee.  Return
	 types are not propagated."

	| sel meth methArgs exitLabel inlineStmts label exitType |
	sel := aSendNode selector.
	meth := aCodeGen methodNamed: sel.
	methArgs := meth args.
	"convenient for debugging..."
	aCodeGen maybeBreakForInlineOf: aSendNode in: self.
	(methArgs notEmpty and: [methArgs first beginsWith: 'self_in_']) ifTrue:
		[methArgs := methArgs allButFirst].
	methArgs size = aSendNode args size ifFalse:
		[^nil].
	meth := meth copy.

	(meth statements size > 1
	 and: [meth statements first isSend
	 and: [meth statements first selector == #flag:]]) ifTrue:
		[meth statements removeFirst].

	"Propagate the return type of an inlined method"
	(directReturn or: [exitVar notNil]) ifTrue:
		[exitType := directReturn 
						ifTrue: [returnType] 
						ifFalse: [(self typeFor: exitVar in: aCodeGen) ifNil: [#sqInt]].
		(exitType = #void or: [exitType = meth returnType]) ifFalse:
			[meth propagateReturnIn: aCodeGen]].

	"Propagate any unusual argument types to untyped argument variables"
	methArgs
		with: aSendNode args
		do: [:formal :actual|
			(meth declarationAt: formal ifAbsent: nil) ifNil:
				[(self typeFor: actual in: aCodeGen) ifNotNil:
					[:type|
					type ~= #sqInt ifTrue:
						[meth declarationAt: formal put: (type last = $* ifTrue: [type, formal] ifFalse: [type, ' ', formal])]]]].

	meth renameVarsForInliningInto: self except: #() in: aCodeGen.
	meth renameLabelsForInliningInto: self.
	self addVarsDeclarationsAndLabelsOf: meth except: #().
	meth hasReturn ifTrue:
		[directReturn ifFalse:
			[exitLabel := self unusedLabelForInliningInto: self.
			 (meth exitVar: exitVar label: exitLabel) "is label used?"
				ifTrue: [ labels add: exitLabel ]
				ifFalse: [ exitLabel := nil ]]].
	(inlineStmts := OrderedCollection new: meth statements size + meth args size + 2)
		add: (label := TLabeledCommentNode new setComment: 'begin ', sel);
		addAll: (self argAssignmentsFor: meth send: aSendNode in: aCodeGen);
		addAll: meth statements.  "method body"
	directReturn ifTrue:
		[meth endsWithReturn
			ifTrue:
				[exitVar ifNotNil: "don't remove the returns if being invoked in the context of a return"
					[inlineStmts at: inlineStmts size put: inlineStmts last copyWithoutReturn]]
			ifFalse:
				[inlineStmts add:
					(TReturnNode new setExpression: (TVariableNode new setName: 'nil'))]].
	exitLabel ifNotNil:
		[inlineStmts add:
			(TLabeledCommentNode new setLabel:
				exitLabel comment: 'end ', meth selector)].
	inlineStmts size = 1 ifTrue: "Nuke empty methods; e.g. override of flushAtCache"
		[self assert: inlineStmts first isComment.
		 inlineStmts removeFirst].
	^inlineStmts