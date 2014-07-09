assembly
send: selector super: supered numArgs: nArgs
	supered ifFalse:
		[(SpecialSelectors at: selector ifAbsent: []) ifNotNil:
			[:specialSelectorIndex|
			 ^encoder genSendSpecial: specialSelectorIndex numArgs: nArgs].
		^encoder genSend: (encoder sharableLitIndex: selector) numArgs: nArgs].
	^encoder genSendSuper: (encoder sharableLitIndex: selector) numArgs: nArgs