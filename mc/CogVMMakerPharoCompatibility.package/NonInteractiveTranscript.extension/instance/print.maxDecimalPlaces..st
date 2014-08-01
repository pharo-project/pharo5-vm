*CogVMMakerPharoCompatibility
print: aNumber maxDecimalPlaces: places
	aNumber 
		printOn: self stream 
		showingDecimalPlaces: places