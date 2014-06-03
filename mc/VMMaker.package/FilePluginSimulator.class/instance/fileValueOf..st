simulation
fileValueOf: objectPointer
	| index file |
	index := (interpreterProxy isIntegerObject: objectPointer)
				ifTrue: [interpreterProxy integerValueOf: objectPointer]
				ifFalse:
					[((interpreterProxy isBytes: objectPointer)
					  and: [(interpreterProxy byteSizeOf: objectPointer) = BytesPerWord]) ifFalse:
						[interpreterProxy primitiveFail.
						 ^nil].
					interpreterProxy longAt: objectPointer + BaseHeaderSize].
	file := openFiles at: index.
	"this attempts to preserve file positions across snapshots when debugging the VM
	 requires saving an image in full flight and pushing it over the cliff time after time..."
	(file closed and: [states includesKey: file]) ifTrue:
		[[:pos :isBinary|
		  file reopen; position: pos.
		  isBinary ifTrue:
			[file binary]] valueWithArguments: (states at: file)].
	^file