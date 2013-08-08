utils
doesNotUnderstand: aMessage
	" ignore configureXYZ: messages "

	| sel  |
	sel := aMessage selector.
	
	((sel beginsWith: 'configure') and: [
		(sel indexOf: $: ) = sel size ] ) ifTrue: [ ^ self ].
	
	^ super doesNotUnderstand: aMessage