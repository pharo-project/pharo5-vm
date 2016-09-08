primitives
primSetTextEnc: encoding

	| name len |
	<export: true>
	<var: #name type: 'char *'>
	<var: #len type: 'size_t'>
	len := interpreterProxy stSizeOf: encoding.
	name := self cCoerce: (interpreterProxy firstIndexableField: encoding) to: 'char *'.
	self cCode: 'setNEncoding(&uxTextEncoding, name, len)'.
	^ encoding.