C code generator
emitCFunctionPrototypes: methodList on: aStream 
	"Store prototype declarations for all non-inlined methods on the given stream."
	| exporting |
	aStream cr; nextPutAll: '/*** Function Prototypes ***/'; cr.
	"Add a define for a NoDbgRegParms attribute for static functions used for debugging.
	 gcc and other compilers will use non-standard calling conventions for static functions
	 when optimizing.  This can render the functions unusable in gdb.  The sqConfig.h file
	 for the platform should define PlatformNoDbgRegParms suitably for the platform's
	 compiler, if the compiler can be persuaded not to generate such functions."
	"Add a define for a NeverInline attribute that tells the compiler never to inline functions
	 with the attribute.  We mark functions we want to observe in a profiler as NeverInline.
	 The sqConfig.h file for the platform should define NeverInline suitably for the platform's
	 compiler, if the compiler can be persuaded not to inline certain functions."
	vmClass notNil ifTrue:
		[NoRegParmsInAssertVMs ifTrue:
			[aStream nextPutAll: '\\#if !PRODUCTION && defined(PlatformNoDbgRegParms)\# define NoDbgRegParms PlatformNoDbgRegParms\#endif' withCRs.
			 aStream nextPutAll: '\\#if !defined(NoDbgRegParms)\# define NoDbgRegParms /*empty*/\#endif\\' withCRs].
		 aStream nextPutAll: '\\#if !defined(NeverInline)\# define NeverInline /*empty*/\#endif\\' withCRs].
	exporting := false.
	(methodList select: [:m| m isRealMethod
							 and: [self shouldGenerateMethod: m]]) do:
		[:m |
		self emitExportPragma ifTrue:
			[m export
				ifTrue: [exporting ifFalse: 
							[aStream nextPutAll: '#pragma export on'; cr.
							exporting := true]]
				ifFalse: [exporting ifTrue: 
							[aStream nextPutAll: '#pragma export off'; cr.
							exporting := false]]].
		m emitCFunctionPrototype: aStream generator: self.
		(NoRegParmsInAssertVMs and: [vmClass notNil and: [m export not and: [m isStatic and: [m args notEmpty]]]]) ifTrue:
			[aStream nextPutAll: ' NoDbgRegParms'].
		(vmClass notNil and: [m inline == #never]) ifTrue:
			[aStream nextPutAll: ' NeverInline'].
		aStream nextPut: $; ; cr].
	exporting ifTrue: [aStream nextPutAll: '#pragma export off'; cr].
	aStream cr