private
checkedUnsignedIntPtrOf: oop
	"Return an unsigned int pointer to the first indexable word of oop, which must be a words object."

	<inline: true>
	<returnTypeC: 'unsigned int *'>

	interpreterProxy success: (interpreterProxy isWords: oop).
	interpreterProxy failed ifTrue: [^ 0].
	^ self cCoerce: (interpreterProxy firstIndexableField: oop) to: 'unsigned int *'
