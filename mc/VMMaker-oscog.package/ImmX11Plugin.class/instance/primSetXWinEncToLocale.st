primitives
primSetXWinEncToLocale

	| ret |
	<export: true>
	self primitive: 'primSetXWinEncToLocale'.
	
	(self cCode: '(int) localeEncoding')
		ifFalse: [ ret := interpreterProxy falseObject ] 
		ifTrue: [
			self cCode: 'uxXWinEncoding = (void *)localeEncoding'.
			ret := interpreterProxy trueObject
		].
	^ ret