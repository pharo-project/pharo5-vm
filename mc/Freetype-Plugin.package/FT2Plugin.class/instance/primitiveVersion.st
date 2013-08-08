primitives-FT2Version
primitiveVersion
	| rcvr apatch amajor aminor |
	self var: #amajor type: 'int'.
	self var: #aminor type: 'int'.
	self var: #apatch type: 'int'.
	rcvr := self
				primitive: 'primitiveVersion'
				parameters: #()
				receiver: #FT2Version.
	errorCode := 0.
	self cCode: 'FT_Library_Version(library, &amajor, &aminor, &apatch)'.
	self touch: amajor.
	interpreterProxy
		storeInteger: 0
		ofObject: rcvr
		withValue: amajor.
	self touch: aminor.
	interpreterProxy
		storeInteger: 1
		ofObject: rcvr
		withValue: aminor.
	self touch: apatch.
	interpreterProxy
		storeInteger: 2
		ofObject: rcvr
		withValue: apatch