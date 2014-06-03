helper
usage
	| usage |
	"Example usage: SMarkHarness SMarkRunner SMarkReporter SMarkLoops.benchIntLoop 1 1 5"
	
	usage := self usageHeader.
	
	usage := usage, 'Arguments:', String crlf.
	usage := self usageRunner:   usage.
	usage := self usageReporter: usage.
	usage := usage, ' suiteOrBenchmark   required, either a SMarkSuite with benchmarks,', String crlf.
	usage := usage, '                              or a benchmark denoted by Suite.benchName', String crlf.
	usage := self usageBenchmarkParameters: usage.
	
	self defaultOutputDestination print: usage.