translation
declareCVarsIn: aCCodeGenerator
	#(eden futureSpace pastSpace) do:
		[:var| aCCodeGenerator var: var type: #SpurNewSpaceSpace].
	aCCodeGenerator
		var: #rememberedSet
		declareC: 'sqInt rememberedSet[RememberedSetLimit + 1 /* ', (RememberedSetLimit + 1) printString, ' */]'