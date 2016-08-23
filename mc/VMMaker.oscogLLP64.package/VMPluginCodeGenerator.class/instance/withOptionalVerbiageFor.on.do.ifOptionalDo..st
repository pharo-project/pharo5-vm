C translation
withOptionalVerbiageFor: selector on: aStream do: mainBlock ifOptionalDo: optionalBlock
	(InterpreterProxy >> selector pragmaAt: #option:)
		ifNil:
			[mainBlock value]
		ifNotNil:
			[:pragma|
			 self emitIfdefForPluginFunctionOption: pragma arguments first on: aStream.
			 aStream cr.
			 mainBlock value.
			 aStream nextPutAll: '#else'; cr.
			 optionalBlock value.
			 aStream nextPutAll: '#endif'; cr]