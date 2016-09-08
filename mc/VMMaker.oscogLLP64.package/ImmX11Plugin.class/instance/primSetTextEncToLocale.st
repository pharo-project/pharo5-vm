primitives
primSetTextEncToLocale

	| ret |
	<export: true>
	self primitive: 'primSetTextEncToLocale'.
	
	(self cCode: '(int) localeEncoding')
		ifFalse: [ ret := interpreterProxy falseObject ] 
		ifTrue: [
			self cCode: 'uxTextEncoding = (void *)localeEncoding'.
			ret := interpreterProxy trueObject
		].
	^ ret