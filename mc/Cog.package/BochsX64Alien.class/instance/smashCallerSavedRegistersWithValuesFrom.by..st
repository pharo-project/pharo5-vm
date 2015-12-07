accessing-abstract
smashCallerSavedRegistersWithValuesFrom: base by: step
	#(rax: rcx: rdx: rsi: rdi: r8: r9: r10: r11:)
	   withIndexDo:
		[:accessor :index|
		self perform: accessor with: index - 1 * step + base]