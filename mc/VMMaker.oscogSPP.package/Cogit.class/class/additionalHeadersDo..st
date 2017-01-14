translation
additionalHeadersDo: aBinaryBlock
	"Evaluate aBinaryBlock with the names and contents of
	 any additional header files that need to be generated."

	NewspeakVM ifTrue:
		[aBinaryBlock
			value: 'cogmethod.h'
			value: NewspeakCogMethod cogMethodHeader.
		 aBinaryBlock
			value: 'nssendcache.h'
			value: NSSendCache typedef.
		 ^self].

	aBinaryBlock
		value: 'cogmethod.h'
		value: CogMethod cogMethodHeader