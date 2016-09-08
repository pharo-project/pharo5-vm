transformations
buildCaseStmt: aSendNode in: aCodeGen
	"Build a case statement node for the given send of dispatchOn:in:."
	"Note: the first argument is the variable to be dispatched on. The second argument is a constant node holding an array of unary selectors, which will be turned into sends to self."

	| unimplemented errorMessage |
	(aSendNode args size >= 2
	 and: [aSendNode args second isConstant
	 and: [aSendNode args second value isArray]]) ifFalse:
		[self error: 'wrong node structure for a case statement'].

	unimplemented := aSendNode args second value select: [:s| (aCodeGen methodNamed: s) isNil].
	unimplemented isEmpty ifFalse:
		[errorMessage := 'The following selectors in case statement "', (aSendNode printString copyUpTo: $#), '..." are unimplemented: ',
							(String streamContents: [:s| unimplemented do: [:sel| s crtab; store: sel]]).
		 aCodeGen logger nextPutAll: errorMessage; cr; flush.
		 (self confirm: errorMessage
			orCancel: aCodeGen abortBlock) ifFalse:
				[self halt]].

	^TCaseStmtNode new
		setExpression: aSendNode args first
		selectors: aSendNode args second value
		arguments: (aSendNode args copyFrom: 3 to: aSendNode args size)