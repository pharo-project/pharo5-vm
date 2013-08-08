accessing
addToOpenPICList: anOpenPIC
	<var: #anOpenPIC type: #'CogMethod *'>
	self assert: anOpenPIC cmType = CMOpenPIC.
	self assert: (openPICList == nil
				or: [openPICList cmType = CMOpenPIC]).
	anOpenPIC nextOpenPIC: openPICList asUnsignedInteger.
	openPICList := anOpenPIC