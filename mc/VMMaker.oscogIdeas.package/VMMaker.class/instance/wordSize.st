initialize
wordSize
	"Return the bytes in a word for the chosen 32bit/64bit pointer setup chosen"
	^is64BitVM ifTrue:[8] ifFalse:[4]