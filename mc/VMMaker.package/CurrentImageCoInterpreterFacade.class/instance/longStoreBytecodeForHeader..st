accessing
longStoreBytecodeForHeader: methodHeaderOop
	"Answer the relevant long store temp bytecode, which indicates it has a primitive error code."
	"234		11101010	i i i i i i i i	Store Temporary Variable #iiiiiiii"
	"129 		10000001 jjkkkkkk 	Store (Receiver Variable, Temporary Location, Illegal, Literal Variable) [jj] #kkkkkk"
	^coInterpreter longStoreBytecodeForHeader: methodHeaderOop
	"was: ^(headerToMethodMap at: methodHeaderOop) usesAlternateBytecodeSet
		ifTrue: [234]
		ifFalse: [129]"