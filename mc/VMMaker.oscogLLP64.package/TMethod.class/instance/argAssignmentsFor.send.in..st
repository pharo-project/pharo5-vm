inlining
argAssignmentsFor: meth send: aSendNode in: aCodeGen
	"Return a collection of assignment nodes that assign the given argument expressions to the formal parameter variables of the given method."
	"Optimization: If the actual parameters are either constants or local variables in the target method (the receiver), substitute them directly into the body of meth. Note that global variables cannot be subsituted because the inlined method might depend on the exact ordering of side effects to the globals."

	| stmtList substitutionDict argList |
	meth args size > (argList := aSendNode args) size ifTrue:
		[self assert: (meth args first beginsWith: 'self_in_').
		 argList := {aSendNode receiver}, aSendNode args].
	
	stmtList := OrderedCollection new: argList size.
	substitutionDict := Dictionary new: argList size.
	meth args with: argList do:
		[:argName :exprNode |
		(self isNode: exprNode substitutableFor: argName inMethod: meth in: aCodeGen)
			ifTrue:
				[substitutionDict
					at: argName
					put: (aCodeGen
							node: exprNode
							typeCompatibleWith: argName
							inliningInto: meth
							in: self).
				 locals remove: argName.
				declarations removeKey: argName ifAbsent: nil]
			ifFalse:
				[stmtList addLast:
					(TAssignmentNode new
						setVariable: (TVariableNode new setName: argName)
						expression: (aCodeGen
										node: exprNode copy
										typeCompatibleWith: argName
										inliningInto: meth
										in: self))]].
	meth parseTree: (meth parseTree bindVariablesIn: substitutionDict).
	^stmtList