translation
preGenerationHook: aCCodeGenerator
	"Override to undo the hiding of primitiveClosureValueNoContextSwitch"
	super preGenerationHook: aCCodeGenerator.
	(aCCodeGenerator methodNamed: #primitiveClosureValueNoContextSwitch) static: false.

	"horrible hack to declare primErrorCode and argumentCount as bytes in the same word, and
	 hence save an instruction by initializing two birds^H^H^H^H^Hbytes with one word write.
	 Stalled awaiting MoveAbR and MoveRAb support in the Cogit"
	false ifTrue:
		[aCCodeGenerator
			var: #argumentCount declareC: '#define argumentCount acpfc.ac\#define primFailCode acpfc.pfc' withCRs;
			var: #primFailCode declareC: '#if VMBIGENDIAN\struct { short pad; unsigned char pfc; unsigned char ac; } acpfc;\#else /* argumentCount & primFailCode */\struct { unsigned char ac; unsigned char pfc; } acpfc;\#endif' withCRs]