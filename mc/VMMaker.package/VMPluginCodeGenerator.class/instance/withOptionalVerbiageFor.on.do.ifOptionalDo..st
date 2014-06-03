C translation
withOptionalVerbiageFor: selector on: aStream do: mainBlock ifOptionalDo: optionalBlock
	(InterpreterProxy >> selector pragmaAt: #option:)
		ifNil:
			[mainBlock value]
		ifNotNil:
			[:pragma|
			 aStream cr.
			 self emitIfdefForPluginFunctionOption: pragma arguments first on: aStream.
			 mainBlock value.
			 aStream cr; nextPutAll: '#else'.
			 optionalBlock value.
			 aStream cr; nextPutAll: '#endif']