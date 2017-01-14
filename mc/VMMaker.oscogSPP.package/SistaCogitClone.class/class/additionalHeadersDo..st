translation
additionalHeadersDo: aBinaryBlock
	"Evaluate aBinaryBlock with the names and contents of
	 any additional header files that need to be generated."
	aBinaryBlock
		value: 'cogmethod.h'
		value: SistaCogMethod cogMethodHeader