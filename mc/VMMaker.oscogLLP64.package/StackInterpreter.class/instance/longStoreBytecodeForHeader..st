compiled methods
longStoreBytecodeForHeader: methodHeader
	"Answer the relevant long store temp bytecode, which indicates it has a primitive error code."
	"234		11101010	i i i i i i i i	Store Temporary Variable #iiiiiiii"
	"129 		10000001 jjkkkkkk 	Store (Receiver Variable, Temporary Location, Illegal, Literal Variable) [jj] #kkkkkk"
	<api>
	<inline: true>
	^self cppIf: MULTIPLEBYTECODESETS
		ifTrue: [(objectMemory headerIndicatesAlternateBytecodeSet: methodHeader)
					ifTrue: [AltLongStoreBytecode]
					ifFalse: [LongStoreBytecode]]
		ifFalse: [LongStoreBytecode]