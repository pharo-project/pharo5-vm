simulation
initBBOpTable
	opTable := OpTable.
	maskTable := Array new: 32.
	#(1 2 4 5 8 16 32) do:[:i| maskTable at: i put: (1 << i)-1].
	self initializeDitherTables.
	warpBitShiftTable := CArrayAccessor on: (Array new: 32).