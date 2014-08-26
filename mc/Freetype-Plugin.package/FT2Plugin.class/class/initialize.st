class initialization
initialize
	"self initialize"
	self classPool. "Ensures classPool"
	#(FT2Face Form FT2GlyphSlot FT2Outline) do: [:clsName |
		| index |
		index := 0.
		(Smalltalk at: clsName) allInstVarNames do: [:var |
			classPool
				at: (clsName, var capitalized, 'Index') asSymbol
				put: index.
			index := index + 1].
		 classPool
			at: (clsName, 'InstSize') asSymbol
			put: index]