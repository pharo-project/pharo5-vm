accessing
compileTimeOptionPragmas
	"Answer the (possibly empty) sequence of option: or notOption: pragmas
	 whose arguments are values to be defined at compile time."
	^self compiledMethod pragmas select:
		[:pragma|
		 (#option: == pragma keyword or: [#notOption: == pragma keyword])
		 and: [VMBasicConstants defineAtCompileTime: (pragma argumentAt: 1)]]