*CogVMMakerPharoCompatibility
perform: aSymbol with: firstObject with: secondObject with: thirdObject with: fourthObject with: fifthObject
	"Send the selector, aSymbol, to the receiver with the given arguments.
	Fail if the number of arguments expected by the selector is not four.
	Primitive. Optional. See Object documentation whatIsAPrimitive."

	^ self 
		perform: aSymbol
		withArguments: { firstObject. secondObject. thirdObject. fourthObject. fifthObject }