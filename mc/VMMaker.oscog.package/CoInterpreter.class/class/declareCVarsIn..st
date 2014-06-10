translation
declareCVarsIn: aCCodeGenerator
	"Override to avoid repeating StackInterpreter's declarations and add our own extensions"
	| threaded |
	self class == thisContext methodClass ifFalse: [^self]. "Don't duplicate decls in subclasses"
	threaded := aCCodeGenerator vmClass isThreadedVM.
	aCCodeGenerator
		addHeaderFile:'"sqCogStackAlignment.h"';
		addHeaderFile:'"cogmethod.h"';
		addHeaderFile: (threaded ifTrue: ['"cointerpmt.h"'] ifFalse: ['"cointerp.h"']);
		addHeaderFile:'"cogit.h"'.
	self declareInterpreterVersionIn: aCCodeGenerator
		defaultName: (threaded ifTrue: ['Cog MT'] ifFalse: ['Cog']).
	aCCodeGenerator
		var: #heapBase type: #usqInt;
		var: #statCodeCompactionUsecs type: #usqLong;
		var: #maxLiteralCountForCompile
			declareC: 'sqInt maxLiteralCountForCompile = MaxLiteralCountForCompile /* ', MaxLiteralCountForCompile printString, ' */';
		var: #minBackwardJumpCountForCompile
			declareC: 'sqInt minBackwardJumpCountForCompile = MinBackwardJumpCountForCompile /* ', MinBackwardJumpCountForCompile printString, ' */'.
	aCCodeGenerator
		var: #reenterInterpreter
		declareC: 'jmp_buf reenterInterpreter; /* private export */'.
	aCCodeGenerator
		var: #primTraceLogIndex type: #'unsigned char';
		var: #primTraceLog declareC: 'sqInt primTraceLog[256]';
		var: #traceLog
		declareC: 'sqInt traceLog[TraceBufferSize /* ', TraceBufferSize printString, ' */]';
		var: #traceSources type: #'char *' array: TraceSources