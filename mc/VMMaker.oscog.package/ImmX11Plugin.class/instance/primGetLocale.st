primitives
primGetLocale

	| ret array len locale |

	<export: true>
	<var: #len type: 'int'>
	<var: #array type: 'char *'>
	<var: #locale type: 'char *'>
	
	locale := self cCode: 'setlocale(LC_CTYPE, "")'.
	(self cCode: 'locale')
		ifFalse: [ ret := interpreterProxy nilObject ]
		ifTrue: [
			len := self cCode: 'strlen(locale)'.
			ret := interpreterProxy
				instantiateClass: interpreterProxy classString
				indexableSize: len.
			array := self cCoerce: (interpreterProxy firstIndexableField: ret) to: 'char *'.
			self cCode: 'strncpy(array, (char *)locale, len)'.
		].	
	^ ret.