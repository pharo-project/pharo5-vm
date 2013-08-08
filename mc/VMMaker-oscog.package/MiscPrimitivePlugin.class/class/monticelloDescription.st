translation
monticelloDescription
	"Override to include the primitive-supplying classes."
	"self monticelloDescription"
	^super monticelloDescription, '\' withCRs,
	 ((self translatedPrimitives
		collect: [:pair| CCodeGenerator monticelloDescriptionFor: (Smalltalk classNamed: pair first)])
			asSet asArray sort reduce: [:a :b| a, '\' withCRs, b])