private
checkedFloatPtrOf: oop
	"Return an unsigned int pointer to the first indexable word of oop, which must be a words object."

	<inline: true>
	<returnTypeC: 'double *'>

	interpreterProxy success: (interpreterProxy isWordsOrBytes: oop).
	interpreterProxy failed ifTrue: [^ 0].
	^ self cCoerce: (interpreterProxy firstIndexableField: oop) to: 'double *'
