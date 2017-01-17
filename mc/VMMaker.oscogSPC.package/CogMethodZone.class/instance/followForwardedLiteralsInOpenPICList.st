jit - api
followForwardedLiteralsInOpenPICList
	<option: #SpurObjectMemory>
	| openPIC |
	<var: #openPIC type: #'CogMethod *'>
	openPIC := openPICList.
	[openPIC notNil] whileTrue:
		[cogit followForwardedLiteralsIn: openPIC.
		 openPIC := self cCoerceSimple: openPIC nextOpenPIC to: #'CogMethod *'.]