I am the rump method header for a block method embedded in a full CogMethod.  I am the superclass of CogMethod, which is a Cog method header proper.  Instances of both classes have the same second word.  The homeOffset abd startpc fields are overlaid on the objectHeader in a CogMethod.  In C I look like

	typedef struct {
		unsigned short	homeOffset;
		unsigned short	startpc;

		unsigned		cmNumArgs : 8;
		unsigned		cmType : 3;
		unsigned		cmRefersToYoung : 1;
		unsigned		cmIsUnlinked : 1;
		unsigned		cmUsageCount : 3;
		unsigned		stackCheckOffset : 16;
	} CogBlockMethod;

My instances are not actually used.  The methods exist only as input to Slang.  The simulator uses my surrogates (CogBlockMethodSurrogate32 and CogBlockMethodSurrogate64.