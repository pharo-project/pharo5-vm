user interface
open: aSyntaxError
	"Answer a standard system view whose model is an instance of me."

	| topView |
	<primitive: 19> "Simulation guard"
	Smalltalk isMorphic
		ifTrue:
			[self buildMorphicViewOn: aSyntaxError.
			CurrentProjectRefactoring newProcessIfUI: Processor activeProcess.
			^ Processor activeProcess suspend].
	topView := self buildMVCViewOn: aSyntaxError.
	topView controller openNoTerminateDisplayAt: Display extent // 2.
	Cursor normal show.
	Processor activeProcess suspend