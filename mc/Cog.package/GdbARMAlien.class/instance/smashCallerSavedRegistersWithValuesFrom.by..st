accessing-abstract
smashCallerSavedRegistersWithValuesFrom: base by: step
	#(r0: r1: r2: r3: r9: r12: lr:) withIndexDo:
		[:accessor :index|
		self perform: accessor with: index - 1 * step + base]