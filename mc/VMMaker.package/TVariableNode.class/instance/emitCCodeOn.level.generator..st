C code generation
emitCCodeOn: aStream level: level generator: aCodeGen

	aStream nextPutAll: (name = 'nil'
						ifTrue: [ aCodeGen cLiteralFor: nil ]
						ifFalse: [ aCodeGen returnPrefixFromVariable: name ])