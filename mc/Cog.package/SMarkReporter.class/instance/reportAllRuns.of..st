reporting
reportAllRuns: aListOfResults of: benchmark
	aListOfResults do: [:result |
		result criteria keysAndValuesDo: [:benchName :timer |
			stream << benchName << ': ' << (timer totalTime asString, 'ms'); cr.]]