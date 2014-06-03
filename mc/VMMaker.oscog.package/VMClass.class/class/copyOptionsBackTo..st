initialization
copyOptionsBackTo: optionsDictionary
	"Ugh.  Copy back those options that the CCodeGenerator will do
	 dead-code elimination for that are not yet set in optionsDictionary.
	 This lets the CCodeGenerator see defaults for the options below."

	optionsDictionary ifNil: [^self].
	initializationOptions ifNil: [^self].
	#(MULTIPLEBYTECODESETS IMMUTABILITY) do:
		[:option|
		((initializationOptions includesKey: option)
		 and: [(optionsDictionary includesKey: option) not]) ifTrue:
			[optionsDictionary at: option put: (initializationOptions at: option)]]