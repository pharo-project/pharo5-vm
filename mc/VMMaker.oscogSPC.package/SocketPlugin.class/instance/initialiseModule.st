initialize-release
initialiseModule
	<export: true>
	sDSAfn := interpreterProxy ioLoadFunction: 'secDisableSocketAccess' From: 'SecurityPlugin'.
	sHSAfn := interpreterProxy ioLoadFunction: 'secHasSocketAccess' From: 'SecurityPlugin'.
	sCCTPfn := interpreterProxy ioLoadFunction: 'secCanConnectToPort' From: 'SecurityPlugin'.
	sCCLOPfn := interpreterProxy ioLoadFunction: 'secCanListenOnPort' From: 'SecurityPlugin'.
	sCCSOTfn := interpreterProxy ioLoadFunction: 'secCanCreateSocketOfType' From: 'SecurityPlugin'.
	^self socketInit