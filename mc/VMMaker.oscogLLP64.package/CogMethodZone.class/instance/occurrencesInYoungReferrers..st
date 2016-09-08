young referers
occurrencesInYoungReferrers: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	| count pointer |
	<var: #pointer type: #usqInt>
	self assert: youngReferrers <= limitAddress.
	count := 0.
	pointer := youngReferrers.
	[pointer < limitAddress] whileTrue:
		[cogMethod asInteger = (objectMemory longAt: pointer) ifTrue:
			[count := count + 1].
		 pointer := pointer + objectMemory wordSize].
	^count