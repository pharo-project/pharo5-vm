C code generator
preDeclareInterpreterProxyOn: aStream
	"Put the necessary #defines needed before interpreterProxy.  Basically
	 internal plugins use the VM's interpreterProxy variable and external plugins use
	 their own.  In addition the VMPluginCodeGenerator can choose to keep local copies
	 all functions."
	aStream cr; nextPutAll: '#ifdef SQUEAK_BUILTIN_PLUGIN'.
	aStream cr; nextPutAll: 'extern'.
	aStream cr; nextPutAll: '#endif'; cr