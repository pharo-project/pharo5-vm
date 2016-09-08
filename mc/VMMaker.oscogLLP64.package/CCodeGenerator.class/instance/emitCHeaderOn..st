C code generator
emitCHeaderOn: aStream
	"Emit the initial part of a source file on aStream, comprising the version stamp,
	 the global struct usage flags, the header files and preamble code."

	| headerClass |
	headerClass := [vmClass coreInterpreterClass]
						on: MessageNotUnderstood
						do: [:ex| vmClass].
	aStream nextPutAll: (self fileHeaderVersionStampForSourceClass: headerClass); cr; cr.
	self emitGlobalStructFlagOn: aStream.

	self addHeaderFileFirst: '"sq.h"'.
	"Additional header files; include C library ones first."
	self emitHeaderFiles: (headerFiles select: [:hdr| hdr includes: $<]) on: aStream.
	"Additional header files; include squeak VM ones last"
	self emitHeaderFiles: (headerFiles reject: [:hdr| hdr includes: $<]) on: aStream.

	vmClass isInterpreterClass ifTrue:
		[self maybePutPreambleFor: vmClass on: aStream].

	aStream cr