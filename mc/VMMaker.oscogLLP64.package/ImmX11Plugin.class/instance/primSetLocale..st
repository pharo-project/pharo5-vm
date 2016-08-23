primitives
primSetLocale: locale

	| name len ret array |
	<export: true>
	<var: #name type: 'char *'>
	<var: #array type: 'char *'>
	<var: #len type: 'size_t'>
	len :=  interpreterProxy stSizeOf: locale.
	name := self cCoerce: (interpreterProxy arrayValueOf: locale) to: 'char *'.
	name := self cCode: 'setLocale(name, len)'.
	(self cCode: '(int) name')
		ifFalse: [^ interpreterProxy nilObject ]
		ifTrue: [
			len := self cCode: 'strlen(name)'.
			ret := interpreterProxy
				instantiateClass: interpreterProxy classString
				indexableSize: len.
			array := self cCoerce: (interpreterProxy firstIndexableField: ret) to: 'char *'.
			self cCode: 'strncpy(array, (char *)name, len)'.
			^ ret ].
