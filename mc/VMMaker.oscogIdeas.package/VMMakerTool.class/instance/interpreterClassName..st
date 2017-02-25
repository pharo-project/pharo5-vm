path access
interpreterClassName: aText
	"set the interpreter class name"

	[vmMaker interpreterClassName: aText asString] 
		on: VMMakerException 
		do: [:ex| self inform:'problem with this class name; does this class exist?'. 
			^false].
	^true