accessing-abstract
smashCallerSavedRegistersWithValuesFrom: base by: step
	#(eax: ecx: edx:)
	   withIndexDo:
		[:accessor :index|
		self perform: accessor with: index - 1 * step + base]