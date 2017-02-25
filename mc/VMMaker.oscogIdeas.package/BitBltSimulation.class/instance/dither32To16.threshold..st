pixel mapping
dither32To16: srcWord threshold: ditherValue
	"Dither the given 32bit word to 16 bit. Ignore alpha."
	| addThreshold  |
	<inline: true> "You bet"
	<returnTypeC: 'unsigned int'>
	<var: #srcWord type: 'unsigned int'>
	addThreshold := ditherValue bitShift: 8.
	^((dither8Lookup at: (addThreshold+((srcWord bitShift: -16) bitAnd: 255))) bitShift: 10) + 
		((dither8Lookup at: (addThreshold+((srcWord bitShift: -8) bitAnd: 255))) bitShift: 5) + 
		(dither8Lookup at: (addThreshold+(srcWord bitAnd: 255))).
