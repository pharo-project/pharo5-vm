garbage collection
markAndTraceOrFreePICTarget: entryPoint in: cPIC
	"If entryPoint is that of some method, then mark and trace objects in it and free if it is appropriate.
	 Answer if the method has been freed."
	<var: #cPIC type: #'CogMethod *'>
	| targetMethod |
	<var: #targetMethod type: #'CogMethod *'>
	self assert: (entryPoint > methodZoneBase and: [entryPoint < methodZone freeStart]).
	(cPIC containsAddress: entryPoint) ifTrue:
		[^false].
	targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
	self assert: (targetMethod cmType = CMMethod or: [targetMethod cmType = CMFree]).
	^self markAndTraceOrFreeCogMethod: targetMethod
		  firstVisit: targetMethod asUnsignedInteger > cPIC asUnsignedInteger