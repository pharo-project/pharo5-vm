inlining
superExpansionNodeFor: aSelector args: argumentNodes
	"Answer the expansion of a super send.  Merge the super expansion's
	 locals, properties and comment into this method's properties."
	(definingClass superclass lookupSelector: aSelector)
		ifNil: [self error: 'superclass does not define super method']
		ifNotNil:
			[:superMethod| | superTMethod commonVars varMap |
			superTMethod := superMethod methodNode asTranslationMethodOfClass: self class.
			((argumentNodes allSatisfy: [:parseNode| parseNode isVariableNode])
			and: [(argumentNodes asOrderedCollection collect: [:parseNode| parseNode key]) = superTMethod args]) ifFalse:
				[self error: definingClass name, '>>',selector, ' args ~= ',
							superTMethod definingClass name, '>>', aSelector,
							(String with: $. with: Character cr),
							'For super expansions to be translated correctly each argument must be a variable with the same name as the corresponding argument in the super method.'].
			(commonVars := superTMethod locals intersection: self locals) notEmpty ifTrue:
				[varMap := Dictionary new.
				 commonVars do:
					[:k| varMap at: k put: (superTMethod unusedNamePrefixedBy: k avoiding: self allLocals)].
				 superTMethod renameVariablesUsing: varMap].
			self mergePropertiesOfSuperMethod: superTMethod.
			self assert: (superTMethod locals allSatisfy: [:var| (self locals includes: var) not]).
			locals addAll: superTMethod locals.
			superTMethod declarations keysAndValuesDo:
				[:var :decl|
				self declarationAt: var put: decl].
			superTMethod comment ifNotNil:
				[:superComment|
				comment := comment
								ifNil: [superComment]
								ifNotNil: [superComment, comment]].
			superTMethod extraVariableNumber ifNotNil:
				[:scvn|
				extraVariableNumber := extraVariableNumber ifNil: [scvn] ifNotNil: [:cvn| cvn + scvn]].
			superTMethod elideAnyFinalReturn.
			^superTMethod parseTree]