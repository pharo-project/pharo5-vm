assertions
genGetLeafCallStackPointerFunction
"create a tiny leaf function that just returns the SP in r0; doesn't seem to actually get used. "
	cogit MoveR: SP R: R0.
	cogit RetN: 0