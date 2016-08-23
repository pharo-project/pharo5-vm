class initialization
initialize
	"Initialize the window color.  This is probably Squeak-specific, so..."
	[Preferences
			setWindowColorFor: #cogVirtualMachineSimulatorWindowColor
			to: (Color colorFrom: InterpreterPrimitives windowColorSpecification brightColor)]
		on: Error
		do: [:ex| Transcript show: 'Failed to set window color preference in ', thisContext method methodReference asString]