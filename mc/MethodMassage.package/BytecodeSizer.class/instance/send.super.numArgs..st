assembly
send: selector super: supered numArgs: nArgs
	supered ifFalse:
		[(SpecialSelectors at: selector ifAbsent: []) ifNotNil:
			[:specialSelectorIndex|
			 ^encoder sizeSpecialSend: specialSelectorIndex numArgs: nArgs].
		^encoder sizeSend: (encoder sharableLitIndex: selector) numArgs: nArgs].
	^encoder sizeSendSuper: (encoder sharableLitIndex: selector) numArgs: nArgs