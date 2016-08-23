primitives
primGetLocaleEncoding

	| ret array len |

	<export: true>
	<var: #len type: 'int'>
	<var: #array type: 'char *'>

	(self cCode: '(int) localeEncoding')
		ifFalse: [ ret := interpreterProxy nilObject ]
		ifTrue: [
			len := self cCode: 'strlen(localeEncoding)'.
			ret := interpreterProxy
				instantiateClass: interpreterProxy classString
				indexableSize: len.
			array := self cCoerce: (interpreterProxy firstIndexableField: ret) to: 'char *'.
			self cCode: 'strncpy(array, (char *)localeEncoding, len)'.
		].	
	^ ret.