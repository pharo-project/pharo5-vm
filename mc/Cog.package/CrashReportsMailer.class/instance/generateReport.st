reporting
generateReport
	causes := Dictionary new.
	self collectReportSummaries.
	self generateFinalReport