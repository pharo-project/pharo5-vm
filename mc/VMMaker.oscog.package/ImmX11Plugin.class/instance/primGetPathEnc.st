primitives
primGetPathEnc

	| ret array len |

	<export: true>
	<var: #len type: 'int'>
	<var: #array type: 'char *'>
	len := self cCode: 'strlen(uxPathEncoding)'.

	ret := interpreterProxy
			instantiateClass: interpreterProxy classString
			indexableSize: len.
	array := self cCoerce: (interpreterProxy firstIndexableField: ret) to: 'char *'.	
	self cCode: 'strncpy(array, (char *)uxPathEncoding, len)'.
	
	^ ret.