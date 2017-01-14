class initialization
initializeFillTable
	"BalloonEngineBase initialize"
	^#(
		errorWrongIndex "Type zero - undefined"
		errorWrongIndex "Type one - external fill"

		fillLinearGradient "Linear gradient fill"
		fillRadialGradient "Radial gradient fill"

		fillBitmapSpan	"Clipped bitmap fill"
		fillBitmapSpan	"Repeated bitmap fill"
	)