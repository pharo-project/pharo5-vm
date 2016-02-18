C code generator
emitCFunctionPrototypes: methodList on: aStream 
	"Store prototype declarations for all non-inlined methods on the given stream.
	 Add a define for a NoDbgRegParms attribute for static functions used for debugging.
	 gcc and other compilers will use non-standard calling conventions for static functions
	 when optimizing.  The optimization can render the functions unusable in gdb.  The sqConfig.h
	 file for the platform should define PlatformNoDbgRegParms suitably for the platform's
	 compiler, if the compiler can be persuaded not to generate such functions.
	 Add a define for a NeverInline attribute that tells the compiler never to inline functions
	 with the attribute.  We mark functions we want to observe in a profiler as NeverInline.
	 The sqConfig.h file for the platform should define NeverInline suitably for the platform's
	 compiler, if the compiler can be persuaded not to inline certain functions."
	aStream cr; nextPutAll: '/*** Function Prototypes ***/'; cr.
	vmClass ifNotNil:
		[NoRegParmsInAssertVMs ifTrue:
			[aStream nextPutAll: '\\#if !PRODUCTION && defined(PlatformNoDbgRegParms)\# define NoDbgRegParms PlatformNoDbgRegParms\#endif' withCRs.
			 aStream nextPutAll: '\\#if !defined(NoDbgRegParms)\# define NoDbgRegParms /*empty*/\#endif\\' withCRs].
		 aStream nextPutAll: '\\#if !defined(NeverInline)\# define NeverInline /*empty*/\#endif\\' withCRs].
	(methodList select: [:m| m isRealMethod and: [self shouldGenerateMethod: m]]) do:
		[:m |
		vmClass ifNotNil:
			[(NoRegParmsInAssertVMs and: [m export not and: [m isStatic and: [m args notEmpty]]]) ifTrue:
				[m addFunctionAttribute: 'NoDbgRegParms'].
			 m inline == #never ifTrue:
				[m addFunctionAttribute: 'NeverInline']].
		m emitCFunctionPrototype: aStream generator: self].
	aStream cr