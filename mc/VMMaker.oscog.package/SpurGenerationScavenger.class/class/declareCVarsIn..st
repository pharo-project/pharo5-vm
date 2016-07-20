translation
declareCVarsIn: aCCodeGenerator
	#(eden futureSpace pastSpace) do:
		[:var| aCCodeGenerator var: var type: #SpurNewSpaceSpace].
	aCCodeGenerator var: #rememberedSet type: #'sqInt *'.
	aCCodeGenerator var: #tenuringProportion type: #double