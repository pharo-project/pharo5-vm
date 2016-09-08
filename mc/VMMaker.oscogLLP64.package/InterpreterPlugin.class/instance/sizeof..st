simulation support
sizeof: objectSymbolOrClass
	<doNotGenerate>
	objectSymbolOrClass isSymbol ifTrue:
		["In the simulator file handles are just integer indices into openFiles and so need
		 only be BytesPerWord big. But in the actual VM they are at least 5 words long."
		objectSymbolOrClass == #SQFile ifTrue:
			[^interpreterProxy wordSize * 5].
		"SQSocket is typedef struct { int sessionID; int socketType; void *privateSocketPtr; } SQSocket"
		objectSymbolOrClass == #SQSocket ifTrue:
			[^8 + interpreterProxy wordSize].
		"We assume the file offset type is always 64-bits."
		objectSymbolOrClass == #squeakFileOffsetType ifTrue:
			[^8].
		(objectSymbolOrClass last == $*
		 or: [#'sqIntptr_t' == objectSymbolOrClass
		 or: [#'usqIntptr_t' == objectSymbolOrClass
		 or: [#'size_t' == objectSymbolOrClass]]]) ifTrue:
			[^interpreterProxy wordSize].
		(#(usqInt sqInt) includes: objectSymbolOrClass) ifTrue:
			[^interpreterProxy bytesPerOop]].
	^super sizeof: objectSymbolOrClass