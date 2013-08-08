private
checkedShortPtrOf: oop
	"Return the first indexable word of oop which is assumed to be variableWordSubclass"
	<returnTypeC: 'short *'>
	interpreterProxy success: (interpreterProxy isWords: oop).
	interpreterProxy failed ifTrue:[^0].
	^self cCoerce: (interpreterProxy firstIndexableField: oop) to:'short *'