testing
isFillOkay: fill
	<inline: false>
	^(fill = 0 or:[(self isFillColor: fill) or:[((self isObject: fill) and:[self isFill: fill])]]) 
