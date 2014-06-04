system primitives
primitiveIsMenuBarVisible
	| result |
	self primitive: 'primitiveIsMenuBarVisible'
		parameters: #().
	result := self cCode: 'IsMenuBarVisible()' inSmalltalk:[true].
	^result asOop: Boolean