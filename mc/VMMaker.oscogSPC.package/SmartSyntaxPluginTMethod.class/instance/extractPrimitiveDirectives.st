specifying primitives
extractPrimitiveDirectives
	"Save selector in fullSelector and args in fullArgs.  Scan top-level statements for a directive of the form:

		self	
			primitive: 	<string>
or
		self
			primitive:	<string>
			parameters: <list of class names>
or
		self
			primitive:	<string>
			parameters: <list of class names>
			receiver: <class name>

or an assignment of that expression to a local, and manipulate the state and parse tree accordingly."

	parseTree setStatements: (Array streamContents:
		[:sStream |
			parseTree statements do:
				[:stmt |
				 (self primitiveDirectiveWasHandled: stmt on: sStream)
					ifFalse: [sStream nextPut: stmt]]]).
	isPrimitive 
		ifTrue:
			[export := true.
			 parseTree 
				setStatements: self namedPrimitiveProlog, 
								parseTree statements.
			 self fixUpReturns.
			 self replaceSizeMessages.
			 ^true]
		ifFalse: [self removeFinalSelfReturnIn: nil].
	^false