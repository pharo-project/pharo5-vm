utility
cWordsPtr: oop minSize: minSize
	"Return a C pointer to the first indexable field of oop, which must be a words object of at least the given size."
	"Warning: the resulting pointer may become invalid after the next garbage collection and should only be using during the current primitive call."

	<returnTypeC: #'void *'>

	interpreterProxy success:
		((interpreterProxy isWords: oop)
		 and: [(interpreterProxy stSizeOf: oop) >= minSize]).
	^interpreterProxy failed
		ifTrue: [0]
		ifFalse: [self cCoerce: (interpreterProxy firstIndexableField: oop) to: #'void *']