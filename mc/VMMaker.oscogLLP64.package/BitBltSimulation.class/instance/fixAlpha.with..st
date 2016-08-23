combination rules
fixAlpha: sourceWord with: destinationWord
	"For any non-zero pixel value in destinationWord with zero alpha channel take the alpha from sourceWord and fill it in. Intended for fixing alpha channels left at zero during 16->32 bpp conversions."
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	destDepth = 32 ifFalse:[^destinationWord]. "no-op for non 32bpp"
	destinationWord = 0 ifTrue:[^0].
	(destinationWord bitAnd: 16rFF000000) = 0 ifFalse:[^destinationWord].
	^destinationWord bitOr: (sourceWord bitAnd: 16rFF000000)
