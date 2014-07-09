reporting
reportConfiguration: aStream
	aStream << 'Runner Configuration:';cr.
	aStream << ('  iterations: ', numIterations asString); cr.
	aStream << ('  processes: ', numProcesses asString); cr.
	aStream << ('  problem size: ', problemSize asString); cr.
