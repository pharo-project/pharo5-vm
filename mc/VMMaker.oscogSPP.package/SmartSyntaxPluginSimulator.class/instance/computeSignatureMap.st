initialize
computeSignatureMap
	forMap := true. "true only while we compute the signatureMap"
	signatureMap := Dictionary new.
	pluginClass selectorsAndMethodsDo:
		[:s :m|
		(m messages includesAnyOf: #(primitive: primitive:parameters: primitive:parameters:receiver:))
			ifTrue: [self getPrimitiveSignatureFor: s]
			ifFalse:
				[(m pragmaAt: #export:) ifNotNil:
					[:exportPragma|
					(exportPragma argumentAt: 1) ifTrue:
						[self computeSignatureFor: s from: { #forMap. s. #(). nil }]]]].
	forMap := false