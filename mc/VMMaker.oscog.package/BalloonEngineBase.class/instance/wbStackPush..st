accessing stack
wbStackPush: nItems
	(self allocateStackEntry: nItems) ifFalse:[^false].
	self wbTopPut: self wbTopGet - nItems.
	^true