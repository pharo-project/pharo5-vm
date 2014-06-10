C translation
atLeastVMProxyMajor: major minor: minor 
	^String streamContents:
		[:s|
		s	nextPutAll: 'VM_PROXY_MAJOR > '; print: major;
			nextPutAll: ' || (VM_PROXY_MAJOR == '; print: major;
			nextPutAll: ' && VM_PROXY_MINOR >= '; print: minor;
			nextPutAll: ')']