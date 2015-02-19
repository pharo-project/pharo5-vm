inlining
transformConditionalAssignment: node in: aCodeGen
	"If possible answer the transformation of code of the form
		var := e1
				ifTrue: [e2 ifTrue: [self m1] ifFalse: [self m2]]
				ifFalse: [self m3]
	 into
		e1
			ifTrue: [e2 ifTrue: [var := self m1] ifFalse: [var := self m2]]
			ifFalse: [var := self m3]
	 to allow inlining of m1, m2, et al.  Otherwise answer nil."

	| expr |
	^(node isAssignment
	   and: [(expr := node expression) isSend
	   and: [(#(ifTrue:ifFalse: ifFalse:ifTrue:) includes: expr selector)
	   and: [self isConditionalToBeTransformedForAssignment: expr  in: aCodeGen]]]) ifTrue:
		[expr copy
			arguments:
				(expr args collect:
					[:stmtList| stmtList copy assignLastExpressionTo: node variable]);
			yourself]