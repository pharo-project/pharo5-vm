accessing-abstract
smashABICallerSavedRegistersWithValuesFrom: base by: step
	"limited list of registers to clear out when simulating an ABI call.
	 Smash neither R0 nor R1 since many abi calls return 2 results or a 64-bit dual-reg value.
	 LR has to be left alone becasue a leaf call doesn't push it."

	#(r2: r3: r9: r12:) withIndexDo:
		[:accessor :index|
		self perform: accessor with: index - 1 * step + base]