user interface
syntaxErrorFor: aString withComponent: anApplescriptInstance

	|range |
	range := anApplescriptInstance lastErrorCodeRange.
	self open:
		(super new 
			code: aString 
			errorMessage: anApplescriptInstance lastErrorString
			from: range first
			to: range last)