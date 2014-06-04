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
	self maybeBreakFor: aSendNode in: aCodeGen.
	(methArgs notEmpty and: [methArgs first beginsWith: 'self_in_']) ifTrue:
		[methArgs := methArgs allButFirst].
	methArgs size = aSendNode args size ifFalse:
		[^nil].
	methArgs with: aSendNode args do:
		[:formal :actual|
		(actual isVariable
		and: [(aCodeGen
				variableOfType: (self typeFor: formal using: aCodeGen)
				acceptsValueOfType: (self typeFor: actual name in: aCodeGen)) not]) ifTrue:
			[aCodeGen logger
				nextPutAll:
					'type mismatch for formal ', formal, ' and actual ', actual name,
					' when inlining ', sel, ' in ', selector, '. Use a cast.';
				cr; flush]]. 
	meth := meth copy.

	"Propagate the return type of an inlined method"
	(directReturn or:[exitVar notNil]) ifTrue:[
		exitType := directReturn 
			ifTrue:[returnType] 
			ifFalse:[(self typeFor: exitVar in: aCodeGen) ifNil:[#sqInt]].
		(exitType = #void or:[exitType = meth returnType]) 
			ifFalse:[meth propagateReturnIn: aCodeGen]].

	meth renameVarsForInliningInto: self except: #() in: aCodeGen.
	meth renameLabelsForInliningInto: self.
	self addVarsDeclarationsAndLabelsOf: meth except: #().
	meth hasReturn ifTrue:[
		directReturn ifFalse:[
			exitLabel := self unusedLabelForInliningInto: self.
			(meth exitVar: exitVar label: exitLabel) "is label used?"
				ifTrue: [ labels add: exitLabel ]
				ifFalse: [ exitLabel := nil ]]].
	(inlineStmts := OrderedCollection new: 100)
		add: (label := TLabeledCommentNode new setComment: 'begin ', sel);
		addAll: (self argAssignmentsFor: meth send: aSendNode in: aCodeGen);
		addAll: meth statements.  "method body"
	"Vile hacks to prevent too many labels.  If the C compiler inlines functions it can duplicate
	 labels and cause compilation to fail.  The second statement prevents us creating labels in
	 anything other than the interpreter.  If we add labels to small functions that may be inlined
	 by the C compiler then the label can be duplicated by the C compiler and cause the assembler
	 to fail.  eem 9/20/2008 12:29"
	(aCodeGen wantsLabels
	 and: [meth asmLabel
	 and: [meth mustAsmLabel or: [meth hasMoreSendsThan: 20]]]) ifTrue:
		[label asmLabel: sel].
	(directReturn
	 and: [meth endsWithReturn not]) ifTrue:
		[inlineStmts add:
			(TReturnNode new setExpression: (TVariableNode new setName: 'nil'))].
	exitLabel ~= nil ifTrue:
		[inlineStmts add:
			(TLabeledCommentNode new setLabel:
				exitLabel comment: 'end ', meth selector)].
	^inlineStmts