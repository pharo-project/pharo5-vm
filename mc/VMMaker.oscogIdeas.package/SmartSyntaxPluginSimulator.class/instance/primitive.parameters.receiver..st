simulation
primitive: primNameString parameters: argumentClassNames receiver: rcvrClassSymbolOrNil
	"If initializing, pass back the type signature.  If executing, answer the receiver or nil."
	forMap
		ifTrue:
			[Notification new
				tag: {#forMap. primNameString. argumentClassNames. rcvrClassSymbolOrNil};
				signal]
		ifFalse:
			[^rcvrClassSymbolOrNil ifNotNil:
				[interpreterProxy stackValue: interpreterProxy methodArgumentCount]]