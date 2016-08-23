api version
vmProxyMinorVersion
	"Define the  VM_PROXY_MINOR version for this VM as used to
	 define the api in platforms/Cross/vm/sqVirtualMachine.[ch]"
	^false
		ifTrue:
			[(initializationOptions at: #SpurObjectMemory ifAbsent: [false])
				ifTrue: [13]
				ifFalse: [12]]
		ifFalse: [13] "As of 4/11/2014 ObjectMemory supports the new API"