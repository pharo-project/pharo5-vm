primitive generators
genPrimitivePerform
	"Generate an in-line perform primitive.  The lookup code requires the selector to be in Arg0Reg.
	 adjustArgumentsForPerform: adjusts the arguments once genLookupForPerformNumArgs:
	 has generated the code for the lookup."
	self MoveMw: (backEnd hasLinkRegister
					ifTrue: [methodOrBlockNumArgs - 1]
					ifFalse: [methodOrBlockNumArgs]) * objectMemory wordSize
		r: SPReg
		R: Arg0Reg.
	^self genLookupForPerformNumArgs: methodOrBlockNumArgs