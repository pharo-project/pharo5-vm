window color
windowColorSpecification
	"Answer a WindowColorSpec object that declares my preference"
	"Preferences
		setWindowColorFor: #cogVirtualMachineSimulatorWindowColor
		to: (Color colorFrom: InterpreterPrimitives windowColorSpecification brightColor)"
	^WindowColorSpec
		classSymbol: self name wording: 'Cog Virtual Machine Simulator'
		brightColor: #(0.645 1.0 1.0) pastelColor: #(0.886 1.0 1.0)
		helpMessage: 'A tool for simulating a virtual machine in the Cog family.'