helper
usageHeader
	| usage |
	usage := 'SMark Benchmark Framework, version: ', self version, String crlf.
	usage := usage, String crlf.
	usage := usage, 'Usage: <vm+image> ', self name, ' [runner] [reporter] <suiteOrBenchmark>', String crlf.
	usage := usage, '                               [iterations [processes [problemSize]]]', String crlf.
	usage := usage, String crlf.
	^ usage