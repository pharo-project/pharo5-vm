accessing-abstract
smashCallerSavedRegistersWithValuesFrom: base by: step
	self callerSavedSmashRegisterAccessors
	   withIndexDo:
		[:accessor :index|
		self perform: accessor with: index - 1 * step + base]