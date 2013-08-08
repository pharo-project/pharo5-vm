primitives
primitivePrimaryMACAddress
	| identifier size resultOop resultPtr |
	
	<export: true>
	<var: #identifier type: 'char *'>
	<var: #resultPtr type: 'char *'>	

	self primitive: #primitivePrimaryMACAddress parameters: #().
	
	interpreterProxy failed ifTrue: [ ^self ].
	
	identifier := self sqPrimaryMACAddress.
	size := self strlen: identifier.
	resultOop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: size.
	resultPtr := interpreterProxy firstIndexableField: resultOop.
	0 to: (size - 1) do: [ :i | 
		resultPtr at: i put: (identifier at: i) ].
	
	^resultOop