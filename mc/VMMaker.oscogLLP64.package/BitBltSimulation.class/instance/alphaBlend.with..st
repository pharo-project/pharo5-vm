combination rules
alphaBlend: sourceWord with: destinationWord
	"Blend sourceWord with destinationWord, assuming both are 32-bit pixels.
	The source is assumed to have 255*alpha in the high 8 bits of each pixel,
	while the high 8 bits of the destinationWord will be ignored.
	The blend produced is alpha*source + (1-alpha)*dest, with
	the computation being performed independently on each color
	component.  The high byte of the result will be 0."
	| alpha unAlpha result blendRB blendAG |
	<inline: false>
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	<var: #blendRB type: 'unsigned int'>
	<var: #blendAG type: 'unsigned int'>
	<var: #result type: 'unsigned int'>
	<var: #alpha type: 'unsigned int'>
	<var: #unAlpha type: 'unsigned int'>
	alpha := sourceWord >> 24.  "High 8 bits of source pixel"
	alpha = 0 ifTrue: [ ^ destinationWord ].
	alpha = 255 ifTrue: [ ^ sourceWord ].
	unAlpha := 255 - alpha.

	blendRB := ((sourceWord bitAnd: 16rFF00FF) * alpha) +
				((destinationWord bitAnd: 16rFF00FF) * unAlpha)
				+ 16rFF00FF.	"blend red and blue"

	blendAG := (((sourceWord>> 8 bitOr: 16rFF0000) bitAnd: 16rFF00FF) * alpha) +
				((destinationWord>>8 bitAnd: 16rFF00FF) * unAlpha)
				+ 16rFF00FF.	"blend alpha and green"

	blendRB := blendRB + (blendRB - 16r10001 >> 8 bitAnd: 16rFF00FF) >> 8 bitAnd: 16rFF00FF.	"divide by 255"
	blendAG := blendAG + (blendAG - 16r10001 >> 8 bitAnd: 16rFF00FF) >> 8 bitAnd: 16rFF00FF.
	result := blendRB bitOr: blendAG<<8.
	^ result
