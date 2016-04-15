I am the rump method header for a block method embedded in a full CogMethod.  I am the superclass of CogMethod, which is a Cog method header proper.  Instances of both classes have the same second word.  The homeOffset and startpc fields are overlaid on the objectHeader in a CogMethod.  See Cogit class>>structureOfACogMethod for more information.  In C I look like

	typedef struct {
		union {
			struct {
				unsigned short	homeOffset;
				unsigned short	startpc;
	#if SpurVM
				unsigned int	padToWord;
	#endif
			};
			sqInt/sqLong	objectHeader;
		};
		unsigned		cmNumArgs : 8;
		unsigned		cmType : 3;
		unsigned		cmRefersToYoung : 1;
		unsigned		cpicHasMNUCaseOrCMIsFullBlock : 1;
		unsigned		cmUsageCount : 3;
		unsigned		cmUsesPenultimateLit : 1;
		unsigned		cbUsesInstVars : 1;
		unsigned		cmUnusedFlags : 2;
		unsigned		stackCheckOffset : 12;
	 } CogBlockMethod;

My instances are not actually used.  The methods exist only as input to Slang.  The simulator uses my surrogates (CogBlockMethodSurrogate32 and CogBlockMethodSurrogate64) to reference CogBlockMethod and CogMethod structures in the code zone.  The start of the structure is 32-bits in the V3 memory manager and 64-bits in the Spour memory manager.  In a CMMethod these bits are set to the object header of a marked bits objects, allowing code to masquerade as objects when referred to from the first field of a CompiledMethod.  In a CMBlock, they hold the homeOffset and the startpc.

cbUsesInstVars
	- a flag set to true in blocks that refer to instance variables.

cmNumArgs
	- the byte containing the block or method arg count

cmRefersToYoung
	- a flag set to true in methods which contain a reference to an object in new space

cmType
	- one of CMFree, CMMethod, CMBlock, CMClosedPIC, CMOpenPIC

cmUnusedFlags
	- as yet unused bits

cmUsageCount
	- a count used to identify older methods in code compaction.  The count decays over time, and compaction frees methods with lower usage counts

cmUsesPenultimateLit
	- a flag that states whether the penultimate literal in the corresponding bytecode method is used.  This in turn is used to check that a become of a method does not alter its bytecode.

cpicHasMNUCaseOrCMIsFullBlock
	- a flag that states whether a CMClosedPIC contains one or more MNU cases which are PIC dispatches used to speed-up MNU processing,
	  or states whether a CMMethod is for a full block instead of for a compiled method.

homeOffset
	- the distance a CMBlock header is away from its enclosing CMMethod header

objectHeader
	- an object header used to fool the garbage collector into thinking that a CMMethod is a normal bits object, so that the first field (the header word) of a bytecoded method can refer directly to a CMMethod without special casing the garbage collector's method scanning code more than it already is.

padToWord
	- a pad that may be necessary to make the homeOffset, startpc, padToWord triple as large as a CMMethod's objectHeader field

stackCheckOffset
	- the distance from the header to the stack limit check in a frame building method or block, used to reenter execution in methods or blocks that have checked for events at what is effectively the first bytecode

startpc
	- the bytecode pc of the start of a CMBlock's bytecode in the bytecode method