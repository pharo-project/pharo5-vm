simulation only
compilationTrace: anInteger
	"  1 = method/block compilation
	   2 = bytecode descriptor.
	   4 = simStack & optStatus
	   8 = spill
	 16 = merge
	 32 = fixup"
	compilationTrace := anInteger