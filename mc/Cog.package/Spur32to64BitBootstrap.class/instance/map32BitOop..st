bootstrap image
map32BitOop: obj32
	"interpreter32 printOop: obj32"
	^map
		at: obj32
		ifAbsent:
			[(heap32 isImmediate: obj32)
				ifTrue:
					[(heap32 isImmediateCharacter: obj32)
						ifTrue: [heap64 characterObjectOf: (heap32 characterValueOf: obj32)]
						ifFalse: [heap64 integerObjectOf: (heap32 integerValueOf: obj32)]]
				ifFalse:
					[| value |
					 self assert: (self isUnmappedObject: obj32).
					 (heap32 isFloatInstance: obj32)
						ifTrue:
							[heap64 smallFloatObjectOf: (heap32 floatValueOf: obj32)]
						ifFalse:
							[interpreter32 initPrimCall.
							 value := interpreter32 signed64BitValueOf: obj32.
							 self deny: interpreter32 failed.
							 heap64 integerObjectOf: value]]]