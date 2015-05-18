translation support
sizeof: objectSymbolOrClass
	<doNotGenerate>
	| index |
	objectSymbolOrClass isInteger ifTrue:
		[^self class objectMemoryClass wordSize].
	objectSymbolOrClass isSymbol ifTrue:
		[(objectSymbolOrClass last == $*
		 or: [#long == objectSymbolOrClass
		 or: [#'unsigned long' == objectSymbolOrClass]]) ifTrue:
			[^self class objectMemoryClass wordSize].
		index := #(	#sqLong #usqLong #double
					#int #'unsigned int' #float
					#short #'unsigned short'
					#char #'unsigned char' #'signed char')
						indexOf: objectSymbolOrClass
						ifAbsent:
							[(#(usqInt sqInt) includes: objectSymbolOrClass) ifTrue: [^self class objectMemoryClass bytesPerOop].
							 self error: 'unrecognized C type name'].
		^#(8 8 8
			4 4 4
			2 2
			1 1 1) at: index].
	^(objectSymbolOrClass isBehavior
		ifTrue: [objectSymbolOrClass]
		ifFalse: [objectSymbolOrClass class])
			alignedByteSizeOf: objectSymbolOrClass
			forClient: self