testing
primitiveIsEnabled
	<export: true>
	| result |
	
	enabled 
		ifTrue: [ result := interpreterProxy trueObject] 
		ifFalse: [ result := interpreterProxy falseObject ].
		
	interpreterProxy pop: interpreterProxy methodArgumentCount + 1 thenPush: result