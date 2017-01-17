class initialization
initialize
	"BalloonEngineBase initialize"
	"BalloonEnginePlugin translateDoInlining: true."
	EdgeInitTable := self initializeEdgeInitTable.
	EdgeStepTable := self initializeEdgeStepTable.
	WideLineWidthTable := self initializeWideLineWidthTable.
	WideLineFillTable := self initializeWideLineFillTable.
	FillTable := self initializeFillTable.

	(Smalltalk classNamed: #BalloonEngineConstants) ifNotNil:
		[:balloonEngineConstants|
		(balloonEngineConstants classPool anySatisfy: [:classVarValue| classVarValue isNil]) ifTrue:
			[balloonEngineConstants initialize]]