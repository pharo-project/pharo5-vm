accessing-abstract
smashRegistersWithValuesFrom: base by: step
	self smashRegisterAccessors
	   withIndexDo:
		[:accessor :index|
		self perform: accessor with: index - 1 * step + base]