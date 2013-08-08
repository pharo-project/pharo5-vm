C translation
generateValue: aTSendNode on: aStream indent: level
	"Reduce [:formal ... :formalN| body ] value: actual ... value: actualN
	 to body with formals substituted for by actuals."
	| substitution substitutionDict |
	self assert: aTSendNode receiver isStmtList.
	self assert: aTSendNode receiver args size = aTSendNode args size.
	substitution := aTSendNode receiver copy.
	substitutionDict := Dictionary new: aTSendNode args size * 2.
	aTSendNode receiver args with: aTSendNode args do:
		[ :argName :exprNode |
		substitutionDict at: argName put: exprNode].
	substitution
		bindVariablesIn: substitutionDict;
		emitCCodeOn: aStream level: level generator: self