helper
usageBenchmarkParameters: usage
	^ usage,		' processes          optional, number of processes/threads used by the benchmarks', String crlf,
				' inner-iterations   optional, number of iterations done by a single process', String crlf,
				' problemSize        optional, depending on benchmark for instance size of used data set', String crlf.
				