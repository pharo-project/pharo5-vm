Here's a doit to generate most of my code:
	| offset crtab |
	offset := 1.
	crtab := String with: Character cr with: Character tab.
	CogStackPage instVarNamesAndTypesForTranslationDo:
		[:name :type| | isByte |
		isByte := type = 'unsigned char'.
		CogStackPageSurrogate32
			compile: name, crtab, '^memory unsigned', (isByte ifTrue: ['ByteAt:'] ifFalse: ['LongAt:']), ' address + ', offset printString
			classified: #accessing.
		CogStackPageSurrogate32
			compile: name, ': aValue', crtab, '^memory unsigned', (isByte ifTrue: ['ByteAt:'] ifFalse: ['LongAt:']), ' address + ', offset printString,
					' put: aValue'
			classified: #accessing.
		offset := offset + (isByte ifTrue: [1] ifFalse: [4])].
	CogStackPageSurrogate32 class compile: 'alignedByteSize', crtab, '^', (offset - 1 + 3 bitAnd: -4) printString classified: #'instance creation'
