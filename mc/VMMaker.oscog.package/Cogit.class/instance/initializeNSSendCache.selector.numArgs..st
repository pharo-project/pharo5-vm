newspeak support
initializeNSSendCache: cacheAddress selector: selector numArgs: numArgs
	| nsSendCache |
	nsSendCache := self cCoerceSimple: cacheAddress to: #'NSSendCache *'.
	nsSendCache selector: selector.
	nsSendCache numArgs: numArgs.
	nsSendCache classTag: 0. "Illegal class tag"