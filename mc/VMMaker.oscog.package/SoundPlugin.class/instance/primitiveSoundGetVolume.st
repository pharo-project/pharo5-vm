primitives
primitiveSoundGetVolume
	"Get the sound input recording level."
	| left right results |
	<var: #left type: #double>
	<var: #right type: #double>
	self primitive: 'primitiveSoundGetVolume'
		parameters: #( ).
	left := 0.
	right := 0.
	self cCode: 'snd_Volume((double *) &left,(double *) &right)'.
	interpreterProxy pushRemappableOop: (right asOop: Float).
	interpreterProxy pushRemappableOop: (left asOop: Float).
	results := interpreterProxy instantiateClass: (interpreterProxy classArray) indexableSize: 2.
	interpreterProxy storePointer: 0 ofObject: results withValue: interpreterProxy popRemappableOop.
	interpreterProxy storePointer: 1 ofObject: results withValue: interpreterProxy popRemappableOop.
	^results