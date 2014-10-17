benchmarking
problemSize
	<omniUnenforced> "Hint for the OMOP that it is part of the meta infrastructure"
	runner             ifNil: [^ self class defaultProblemSize].
	runner problemSize ifNil: [^ self class defaultProblemSize].
	^ runner problemSize