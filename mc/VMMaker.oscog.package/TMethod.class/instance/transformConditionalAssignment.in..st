inlining
transformConditionalAssignment: node in: aCodeGen
	"If possible asnwer the transformation of code of the form
		var := e1
				ifTrue: [e2 ifTrue: [v1] ifFalse: [v2]]
				ifFalse: [v3]
	 into
		e1
			ifTrue: [e2 ifTrue: [var := v1] ifFalse: [var := v2]]
			ifFalse: [var := v3]
	 to allow inlining of v1, v2, et al.  Otherwise answer nil."

	| expr |
	^(node isAssignment
	   and: [(expr := node expression) isSend
	   and: [#(ifTrue:ifFalse: ifFalse:ifTrue:) includes: expr selector]]) ifTrue:
		[expr copy
			arguments:
				(expr args collect:
					[:stmtList| stmtList copy assignLastExpressionTo: node variable]);
			yourself]