primitives
primSetTextEncUTF8: bool

	<export: true>
	self primitive: 'primSetTextEncUTF8'
		parameters: #(Boolean).
	self cCode: 'textEncodingUTF8 = bool'.
	^ bool asOop: Boolean.