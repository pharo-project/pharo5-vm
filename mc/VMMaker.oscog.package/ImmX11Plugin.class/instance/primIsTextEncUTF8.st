primitives
primIsTextEncUTF8

	<export: true>
	self primitive: 'primIsTextEncUTF8'.
	^ (self cCode: 'textEncodingUTF8') asOop: Boolean.