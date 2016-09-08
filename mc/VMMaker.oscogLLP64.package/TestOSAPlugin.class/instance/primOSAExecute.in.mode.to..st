OSA prims
primOSAExecute: script in: context mode: mode to: result

	|component giLocker resultsOfCall |
	component := self primitive: 	'primOSAExecute'
					parameters: #(OSAID OSAID SmallInteger OSAID)
					receiver:	#ComponentInstance.

	self cCode: '
         giLocker = interpreterProxy->ioLoadFunctionFrom("getUIToLock", "");
         if (giLocker != 0) {
            long *foo;
            foo = malloc(sizeof(long)*8);
            foo[0] = 5;
            foo[1] = OSAExecute;
            foo[2] = *component;
            foo[3] = *script;
            foo[4] = *context;
            foo[5] = mode;
            foo[6] = result;
            foo[7] = 0;
            ((int (*) (void *)) giLocker)(foo);
            resultsOfCall = interpreterProxy->positive32BitIntegerFor(foo[7]);
            free(foo); }
'
			inSmalltalk: [[component. giLocker]. resultsOfCall := -1].
	^resultsOfCall asOop: Unsigned