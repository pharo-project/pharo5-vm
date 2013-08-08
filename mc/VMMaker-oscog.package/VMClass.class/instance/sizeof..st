translation support
sizeof: objectSymbolOrClass
	<doNotGenerate>
	| index |
	objectSymbolOrClass isInteger ifTrue:
		[self flag: #Dan.
		 ^BytesPerWord].
	objectSymbolOrClass isSymbol ifTrue:
		[(objectSymbolOrClass last == $*
		 or: [#long == objectSymbolOrClass
		 or: [#'unsigned long' == objectSymbolOrClass]]) ifTrue:
			[^BytesPerWord].
		index := #(	#sqLong #usqLong #double
					#int #'unsigned int' #float
					#short #'unsigned short'
					#char #'unsigned char' #'signed char')
						indexOf: objectSymbolOrClass
						ifAbsent:
							[objectSymbolOrClass = #sqInt ifTrue: [^BytesPerOop].
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