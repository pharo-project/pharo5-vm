primitive support
windowIsClosing
	quitBlock ifNotNil:
		[:effectiveQuitBlock|
		quitBlock := nil. "stop recursion on explicit window close."
		[effectiveQuitBlock value]
			on: BlockCannotReturn
			do: [:ex|]]	"Cause return from #test, et al"