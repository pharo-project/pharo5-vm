simulation support
promptNum: string
	<doNotGenerate>
	| s |
	s := UIManager default request: string, ' (dec)'.
	s := s withBlanksTrimmed.
	^s notEmpty ifTrue:
		[Number readFrom: s readStream]