primitives
primSetEncodingToLocale

	| ret |
	<export: true>
	self primitive: 'primSetEncodingToLocale'.
	
	(self cCode: '(int) localeEncoding')
		ifFalse: [ ret := interpreterProxy falseObject ] 
		ifTrue: [
			self cCode: 'sqTextEncoding = (void *)localeEncoding'.
			ret := interpreterProxy trueObject
		].
	^ ret