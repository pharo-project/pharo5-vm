accessing-abstract
smashABICallerSavedRegistersWithValuesFrom: base by: step
	self callerABISavedSmashRegisterAccessors
	   withIndexDo:
		[:accessor :index|
		self perform: accessor with: index - 1 * step + base]