script entry
run: arguments
	"Executed from the command line using something similar to
	 ./vm my.image SMarkHarness SMarkRunner SMarkReporter SMarkLoops\>\>benchIntLoop 1 1 5
	 ./vm my.image SMarkHarness SMarkRunner SMarkReporter SMarkLoops.benchIntLoop 1 1 5"

	| runner reporter runnerAndReporter |
	
	(self shouldShowUsage: arguments)
		ifTrue: [
			self usage.
			^ self.
		].
	
	runnerAndReporter := self parseArguments: arguments.
	runner := runnerAndReporter first.
	reporter := runnerAndReporter second.  
	
	self execute: runner andReport: reporter. 