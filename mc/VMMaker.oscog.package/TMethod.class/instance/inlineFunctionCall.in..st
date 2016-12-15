inlining
inlineFunctionCall: aSendNode in: aCodeGen
	"Answer the body of the called function, substituting the actual
	 parameters for the formal argument variables in the method body.
	 Assume caller has established that:
		1. the method arguments are all substitutable nodes, and
		2. the method to be inlined contains no additional embedded returns."

	| sel meth doNotRename argsForInlining substitutionDict |
	sel := aSendNode selector.
	meth := (aCodeGen methodNamed: sel) copy.
	meth ifNil:
		[^self inlineBuiltin: aSendNode in: aCodeGen].
	doNotRename := Set withAll: args.
	argsForInlining := aSendNode argumentsForInliningCodeGenerator: aCodeGen.
	meth args with: argsForInlining do:
		[ :argName :exprNode |
		exprNode isLeaf ifTrue:
			[doNotRename add: argName]].
	(meth statements size = 2
	and: [meth statements first isSend
	and: [meth statements first selector == #flag:]]) ifTrue:
		[meth statements removeFirst].
	meth renameVarsForInliningInto: self except: doNotRename in: aCodeGen.
	meth renameLabelsForInliningInto: self.
	self addVarsDeclarationsAndLabelsOf: meth except: doNotRename.
	substitutionDict := Dictionary new: meth args size * 2.
	meth args with: argsForInlining do:
		[ :argName :exprNode |
		substitutionDict at: argName put: exprNode.
		(doNotRename includes: argName) ifFalse:
			[locals remove: argName]].
	meth parseTree bindVariablesIn: substitutionDict.
	^meth parseTree endsWithReturn
		ifTrue: [meth parseTree copyWithoutReturn]
		ifFalse: [meth parseTree]