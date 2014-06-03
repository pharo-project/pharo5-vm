simulation only
breakPC: anAddress
	<doNotGenerate>
	breakPC := anAddress.
	(breakPC isInteger
	 and: [anAddress between: codeBase and: coInterpreter heapBase]) ifTrue:
		[singleStep := true].
	"If there's a breakPC then it is anded with breakBlock's result, so the breakBlock must default to true.
	 If there's no breakPC the break block is used on its own and so must befault to false."
	(breakBlock isNil
	 or: [breakBlock method = thisContext method]) ifTrue:
		[breakBlock := breakPC isInteger
						ifTrue: [[:cogit| processor pc = breakPC]]
						ifFalse: [[:cogit| false]]]