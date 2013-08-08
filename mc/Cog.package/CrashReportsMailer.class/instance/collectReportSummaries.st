reporting
collectReportSummaries
	self candidateMessagesDo:
		[:fn|
		self ifCrashReport: fn do:
			[:lines|
			self addReportFor: lines]]