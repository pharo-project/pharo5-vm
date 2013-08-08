OSA prims
primOSADoScript: source in: context mode: mode resultType: type to: result

	|component resultsOfCall giLocker |
	component := self primitive: 	'primOSADoScript'
					parameters: #(AEDesc OSAID SmallInteger DescType AEDesc)
					receiver:	#ComponentInstance.

	self cCode: '
        giLocker = interpreterProxy->ioLoadFunctionFrom("getUIToLock", "");
        if (giLocker != 0) {
            long *foo;
            foo = malloc(sizeof(long)*9);
            foo[0] = 6;
            foo[1] = OSADoScript;
            foo[2] = *component;
            foo[3] = source;
            foo[4] = *context;
            foo[5] = *type;
            foo[6] = mode;
            foo[7] = result;
            foo[8] = 0;
            ((int (*) (void *)) giLocker)(foo);
            resultsOfCall = interpreterProxy->positive32BitIntegerFor(foo[8]);
            free(foo);}'
			inSmalltalk: [[component. giLocker].  resultsOfCall := -1].
	^resultsOfCall asOop: Unsigned