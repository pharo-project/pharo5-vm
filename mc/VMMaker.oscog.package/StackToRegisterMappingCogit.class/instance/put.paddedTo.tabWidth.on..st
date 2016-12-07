simulation only
put: aString paddedTo: compositionWidth tabWidth: tabWidth on: aStream
	<doNotGenerate>
	| fittedString size width |
	fittedString := aString.
	size := fittedString size.
	[(width := self widthInDefaultFontOf: fittedString) > compositionWidth] whileTrue:
		[size := size - 2.
		 fittedString := aString contractTo: size].
	aStream
		nextPutAll: fittedString;
		tab: compositionWidth - width + (width \\ tabWidth) // tabWidth