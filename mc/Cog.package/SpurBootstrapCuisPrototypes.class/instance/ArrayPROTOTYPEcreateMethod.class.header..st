method prototypes
ArrayPROTOTYPEcreateMethod: numberOfBytesForAllButTrailer class: aCompiledMethodClass header: headerWord 
	| meth delta |
	meth := aCompiledMethodClass newMethod: numberOfBytesForAllButTrailer + self size header: headerWord.
	"copy the trailer data"
	delta := meth size - self size.
	1 to: self size do:
		[:i | meth at: delta + i put: (self at: i)].
	^meth