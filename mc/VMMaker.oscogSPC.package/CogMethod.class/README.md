I am a native Cog method or polymorphic inline cache.  If the former I have been produced by compiling a bytecoded CompiledMethod into machine code by the JIT, and I have a circular reference to that CompiledMethod.  The CompiledMethod's header field is a pointer to me, the CogMethod, and my methodHeader field holds the compiled method's actual header.  My objectHeader field looks like a single word object with a compact header with the mark bit set so as to placate the GC, i.e. make a CogMethod look like an object so that the reference to a CogMethod from a compiled method doesn't break the GC.  The cmType, stackCheckOffset, cmNumArgs & cmNumTemps fields are early in the structure because we place dummy two-word CogMethod headers within a method for each block within it to record this information for each block method (see my superclass CogBlockMethod).  In this case the objectHeader field is overlaid by the homeOffset and startpc fields.  The objectHeader field is also used to hold the relocation distance when compacting methods since when functioning as an obhject header it is a constant value and so can easily be reinitialized.  See Cogit class>>structureOfACogMethod for more information.

In C I look like

	typedef struct {
	    sqInt   objectHeader;
	
	    unsigned        cmNumArgs : 8;
	    unsigned        cmType : 3;
	    unsigned        cmRefersToYoung : 1;
	    unsigned        cmIsUnlinked : 1;
	    unsigned        cmUsageCount : 3;
	    unsigned        stackCheckOffset : 16;
	
	    unsigned short blockSize;
	    unsigned short blockEntryOffset;
	
	    sqInt   methodObject;
	    sqInt   methodHeader;
	    sqInt   selector;
	 } CogMethod;

Note that in a 64-bit system all fields from cmNumArgs through blockEntry fit in a single 64-bit word.

My instances are not actually used.  The methods exist only as input to Slang.  The simulator uses my surrogates (CogMethodSurrogate32 and CogMethodSurrogate64.