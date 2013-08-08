composition
add: aSound
	"Add the given sound with a pan setting of centered and no attenuation."

	self add: aSound pan: 0.5 volume: 1.0.
	^aSound
