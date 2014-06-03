SMarkReporter is a simple formatter of benchmark results. 

Subclass such as SMarkSimpleStatisticsReporter might implement more advanced reporting functionality, e.g., including a statistical evaluation of the results.

Example:

	| f |
	f := TextStream on: String new.
	SMarkSimpleStatisticsReporter reportFor: (SMarkTestRunnerSuiteForAutosizing run: 10) on: f.
	f contents