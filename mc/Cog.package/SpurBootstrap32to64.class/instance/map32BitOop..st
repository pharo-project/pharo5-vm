bootstrap image
map32BitOop: oop32
	^map
		at: oop32
		ifAbsent:
			[(heap32 isImmediate: oop32)
				ifTrue:
					[(heap32 isImmediateCharacter: oop32)
						ifTrue: [heap64 characterObjectOf: (heap32 characterValueOf: oop32)]
						ifFalse: [heap64 integerObjectOf: (heap32 integerValueOf: oop32)]]
				ifFalse:
					[| value |
					 self assert: (self isUnmappedObject: oop32).
					 interpreter32 initPrimCall.
					 value := heap32 positive64BitValueOf: oop32.
					 self deny: interpreter32 failed.
					 heap64 integerObjectOf: value]]