accessing
printOpenPICList
	<api>
	| openPIC |
	<var: #openPIC type: #'CogMethod *'>
	openPIC := openPICList.
	[openPIC == nil] whileFalse:
		[self printCogMethod: openPIC.
		 openPIC := self cCoerceSimple: openPIC nextOpenPIC to: #'CogMethod *']