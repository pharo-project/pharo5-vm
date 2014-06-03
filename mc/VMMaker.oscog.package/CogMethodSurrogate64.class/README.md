Here's a doit to generate my code:
	| offset crtab |
	offset := 1.
	crtab := String with: Character cr with: Character tab.
	CogMethod instVarNamesAndTypesForTranslationDo:
		[:name :type| | isByte class |
		(isByte := type = 'unsigned char') ifFalse:
			[offset := (offset - 1 + 7 bitAnd: -8) + 1].
		class := (CogBlockMethod instVarNames includes: name)
					ifTrue: [CogBlockMethodSurrogate64]
					ifFalse: [CogMethodSurrogate64].
		class
			compile: name, crtab, '^memory unsigned', (isByte ifTrue: ['ByteAt:'] ifFalse: ['LongLongAt:']), ' address + ', offset printString
			classified: #accessing.
		class
			compile: name, ': aValue', crtab, '^memory unsigned', (isByte ifTrue: ['ByteAt:'] ifFalse: ['LongLongAt:']), ' address + ', offset printString,
					' put: aValue'
			classified: #accessing.
		offset := offset + (isByte ifTrue: [1] ifFalse: [8])].
	CogMethodSurrogate64 class compile: 'alignedByteSize', crtab, '^', (offset + 7 bitAnd: -8) printString classified: #'instance creation'
