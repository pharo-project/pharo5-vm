simulation only
widthInDefaultFontOf: aString
	<doNotGenerate>
	^(NewParagraph new
		compose: aString asText
		style: TextStyle default
		from: 1
		in: Display boundingBox;
		adjustRightX)
		extent x