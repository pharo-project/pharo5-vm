translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"Enumerate aBinaryBlock with the names and C type strings for the inst vars to include in the typedef for the reciever."
	"self typedef"
	self instVarNames do:
		[:ivn|
		aBinaryBlock
			value: ivn
			value: (ivn = 'swizzle'
							ifTrue: [#sqInt]
							ifFalse: [#usqInt])]