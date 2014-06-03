helper
usageHeader
	| usage |
	usage := 'SMark Benchmark Framework, version: ', self version, String crlf.
	usage := usage, String crlf.
	usage := usage, 'Usage: <vm+image> ', self name,
				' <suiteOrBenchmark> [processes [inner-iterations [problemSize]]]', String crlf.
	usage := usage, String crlf.
	
	usage := usage, '  This harness is used for weak-scalling benchmarks.', String crlf.
	usage := usage, '  Use the SMarkHarness for more general settings, it offers more options.', String crlf.
	
	usage := usage, String crlf.
	^ usage