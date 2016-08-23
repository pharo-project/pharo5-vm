primitives
primSetPathEncToLocale

	| ret |
	<export: true>
	self primitive: 'primSetPathEncToLocale'.
	
	(self cCode: '(int) localeEncoding')
		ifFalse: [ ret := interpreterProxy falseObject ] 
		ifTrue: [
			self cCode: 'uxPathEncoding = (void *)localeEncoding'.
			ret := interpreterProxy trueObject
		].
	^ ret