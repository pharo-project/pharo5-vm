initialize-release
initialiseModule
	<export: true>
	sCCPfn := interpreterProxy ioLoadFunction: 'secCanCreatePathOfSize' From: 'SecurityPlugin'.
	sCDPfn := interpreterProxy ioLoadFunction: 'secCanDeletePathOfSize' From: 'SecurityPlugin'.
	sCGFTfn := interpreterProxy ioLoadFunction: 'secCanGetFileTypeOfSize' From: 'SecurityPlugin'.
	sCLPfn := interpreterProxy ioLoadFunction: 'secCanListPathOfSize' From: 'SecurityPlugin'.
	sCSFTfn := interpreterProxy ioLoadFunction: 'secCanSetFileTypeOfSize' From: 'SecurityPlugin'.
	sDFAfn := interpreterProxy ioLoadFunction: 'secDisableFileAccess' From: 'SecurityPlugin'.
	sCDFfn := interpreterProxy ioLoadFunction: 'secCanDeleteFileOfSize' From: 'SecurityPlugin'.
	sCOFfn := interpreterProxy ioLoadFunction: 'secCanOpenFileOfSizeWritable' From: 'SecurityPlugin'.
	sCRFfn := interpreterProxy ioLoadFunction: 'secCanRenameFileOfSize' From: 'SecurityPlugin'.
	sHFAfn := interpreterProxy ioLoadFunction: 'secHasFileAccess' From: 'SecurityPlugin'.
	^self cCode: [self sqFileInit] inSmalltalk: [true]