support
pointFromCompactPointEncoding: encodedPoint
	"Answer a point from one of the funky encoded x,y position/size values the VM uses.
	 The issue here is that the values can be negative, each value being in the range -32768 to 32767"
	<inline: #always>
	^interpreterProxy
		makePointwithxValue: (self cCoerceSimple: encodedPoint >> 16 to: #short)
		yValue: (self cCoerceSimple: (encodedPoint bitAnd: 16rFFFF) to: #short)