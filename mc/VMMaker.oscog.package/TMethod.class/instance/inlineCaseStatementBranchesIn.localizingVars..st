inlining
inlineCaseStatementBranchesIn: aCodeGen localizingVars: varsList 
	| maxTemp usedVars v exitLabel |
	maxTemp := 0.
	parseTree nodesDo:
		[:n |
		n isCaseStmt ifTrue:
			[n cases do:
				[:stmtNode | | newStatements stmt meth |
				(stmt := stmtNode statements first) isSend ifTrue:
					[(meth := (aCodeGen methodNamed: stmt selector)) isNil ifFalse:
						[(meth hasUnrenamableCCode
						   or: [meth args notEmpty]) ifFalse:
							[meth := meth copy.
							 meth hasReturn
								ifTrue:
									[exitLabel := meth unusedLabelForInliningInto: self.
									 meth exitVar: nil label: exitLabel.
									 labels add: exitLabel]
								ifFalse: [exitLabel := nil].
							meth renameLabelsForInliningInto: self.
							labels addAll: meth labels.
							newStatements := stmtNode statements asOrderedCollection allButFirst.
							exitLabel ifNotNil:
								[newStatements addFirst: (TLabeledCommentNode new
																setLabel: exitLabel
																comment: 'end case')].
							newStatements
								addFirst: meth asInlineNode;
								addFirst: (TLabeledCommentNode new setComment: meth selector).
							stmtNode setStatements: newStatements]]]]]].
	usedVars := (locals , args) asSet.
	1 to: maxTemp do:
		[:i |
		v := 't' , i printString.
		(usedVars includes: v) ifTrue:
			[self error: 'temp variable name conflicts with an existing local or arg'].
		locals addLast: v].
	"make local versions of the given globals"
	locals addAll: (varsList reject: [:var | usedVars includes: var])