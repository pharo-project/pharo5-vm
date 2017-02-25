class initialization
registerWindowColor
	(Preferences windowColorFor: self name) = Color white
		ifTrue: [ Preferences setWindowColorFor: self name to: (Color colorFrom: self windowColorSpecification brightColor) ].