combination rules
alphaBlendScaled: sourceWord with: destinationWord
	"Blend sourceWord with destinationWord using the alpha value from sourceWord.
	Alpha is encoded as 0 meaning 0.0, and 255 meaning 1.0.
	In contrast to alphaBlend:with: the color produced is

		srcColor + (1-srcAlpha) * dstColor

	e.g., it is assumed that the source color is already scaled."
	| unAlpha rb ag |
	<inline: false>	"Do NOT inline this into optimized loops"
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	<var: #rb type: 'unsigned int'>
	<var: #ag type: 'unsigned int'>
	<var: #unAlpha type: 'unsigned int'>
	unAlpha := 255 - (sourceWord >> 24).  "High 8 bits of source pixel is source opacity (ARGB format)"
	rb := ((destinationWord bitAnd: 16rFF00FF) * unAlpha >> 8 bitAnd: 16rFF00FF) + (sourceWord bitAnd: 16rFF00FF). "blend red and blue components"
	ag := ((destinationWord>>8 bitAnd: 16rFF00FF) * unAlpha >> 8 bitAnd: 16rFF00FF) + (sourceWord>>8 bitAnd: 16rFF00FF). "blend alpha and green components"
	rb := (rb bitAnd: 16rFF00FF) bitOr: (rb bitAnd: 16r1000100) * 16rFF >> 8. "saturate red and blue components if there is a carry"
	ag := (ag bitAnd: 16rFF00FF) << 8 bitOr: (ag bitAnd: 16r1000100) * 16rFF. "saturate alpha and green components if there is a carry"
	^ag bitOr: rb "recompose"