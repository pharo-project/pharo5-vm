api version
emitInterpreterProxyVersionOn: aStream 
	aStream
		nextPutAll: '#define VM_PROXY_MAJOR '; print: self vmProxyMajorVersion; cr;
		nextPutAll: '#define VM_PROXY_MINOR '; print: self vmProxyMinorVersion; cr; cr