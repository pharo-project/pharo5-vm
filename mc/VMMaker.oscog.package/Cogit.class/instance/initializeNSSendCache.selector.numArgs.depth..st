newspeak support
initializeNSSendCache: cacheAddress selector: selector numArgs: numArgs depth: depth
	<inline: true>
	| nsSendCache |
	nsSendCache := self cCoerceSimple: cacheAddress to: #'NSSendCache *'.
	nsSendCache selector: selector.
	nsSendCache numArgs: numArgs.
	nsSendCache depth: depth.
	nsSendCache classTag: objectRepresentation illegalClassTag.
