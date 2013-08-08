C code generator
emitExportsOn: aStream
	"Store all the exported primitives in a form to be used by internal plugins"
	| prefix |
	aStream nextPutAll:'

#ifdef SQUEAK_BUILTIN_PLUGIN

void* ', pluginName,'_exports[][3] = {'.
	prefix := '"', pluginName,'"'.
	(self sortStrings: self exportedPrimitiveNames) do:[:primName|
		aStream cr;
			nextPutAll:'	{'; 
			nextPutAll: prefix; 
			nextPutAll:', "'; 
			nextPutAll: primName; 
			nextPutAll:'", (void*)'; 
			nextPutAll: primName;
			nextPutAll:'},'.
	].
	aStream nextPutAll:'
	{NULL, NULL, NULL}
};

#endif /* ifdef SQ_BUILTIN_PLUGIN */
'