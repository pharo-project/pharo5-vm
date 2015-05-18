public
storeAPIExportHeader: headerName OnFile: fullHeaderPath
	"Store C header code on the given file. Evaluate
	 aBlock with the stream to generate its contents."

	| header |
	header := String streamContents:
				[:s|
				 s nextPutAll: (self fileHeaderVersionStampForSourceClass: nil); cr.
				 self emitCAPIExportHeaderOn: s].
	(self needToGenerateHeader: headerName file: fullHeaderPath contents: header) ifTrue:
		[self storeHeaderOnFile: fullHeaderPath contents: header]