benchmarking
execute: runner andReport: reporter
	runner reportConfiguration: self defaultOutputDestination.
	runner execute.
	reporter runner: runner.
	reporter outputStream: self defaultOutputDestination.
	reporter report.