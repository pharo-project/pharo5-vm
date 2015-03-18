assertions
genGetLeafCallStackPointerFunction
"create a tiny leaf function that just returns the SP in r0 "
	cogit MoveR: SP R: R0.
	cogit RetN: 0