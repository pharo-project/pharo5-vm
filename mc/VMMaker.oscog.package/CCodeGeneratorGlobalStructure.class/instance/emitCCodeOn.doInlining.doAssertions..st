C code generator
emitCCodeOn: aStream doInlining: inlineFlag doAssertions: assertionFlag
	super emitCCodeOn: aStream doInlining: inlineFlag doAssertions: assertionFlag.

	"we add an initialiser for the pointer to the global struct; "
	aStream 
		cr;
		nextPutAll: 'void initGlobalStructure(void) {';cr;
		nextPutAll: '#if SQ_USE_GLOBAL_STRUCT_REG';cr;
		nextPutAll: 'foo = &fum;' ; cr;
		nextPutAll: '#endif';  cr;
		nextPutAll:'}';
		cr