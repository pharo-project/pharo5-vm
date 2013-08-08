code generation
captureOutputDuring: aBlock
	| old result |
	
	old := output.
	output :=  String new writeStream.
	
	aBlock value.
	
	result := output.
	output := old.
	
	^ result contents