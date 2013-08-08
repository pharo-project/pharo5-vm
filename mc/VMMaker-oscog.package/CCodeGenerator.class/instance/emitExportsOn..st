C code generator
emitExportsOn: aStream
	"Store all the exported primitives in a form to be used by the internal named prim system"
	(vmClass isNil or: [vmClass isInterpreterClass]) ifFalse:
		[^self].
	aStream nextPutAll:'

void* vm_exports[][3] = {'.
	(self sortStrings: self exportedPrimitiveNames) do:[:primName|
		aStream cr;
			nextPutAll:'	{"", "'; 
			nextPutAll: primName; 
			nextPutAll:'", (void*)'; 
			nextPutAll: primName;
			nextPutAll:'},'.
	].
	aStream nextPutAll:'
	{NULL, NULL, NULL}
};
'