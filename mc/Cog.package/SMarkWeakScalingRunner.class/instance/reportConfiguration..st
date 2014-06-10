reporting
reportConfiguration: aStream
	super reportConfiguration: aStream.
	aStream << ('inner iterations: ', numInnerIterations asString); cr.