C code generator
emitCFunctionPrototypes: methodList on: aStream 
	"Store prototype declarations for all non-inlined methods on the given stream."
	| exporting |
	aStream cr; nextPutAll: '/*** Function Prototypes ***/'; cr.
	"Hmm, this should be in the sqConfig.h files.  For now put it here..."
	(NoRegParmsInAssertVMs and: [vmClass notNil]) ifTrue:
		[aStream cr; cr; nextPutAll: '#if defined(PRODUCTION) && !PRODUCTION && defined(__GNUC__) && !defined(NoDbgRegParms)\# define NoDbgRegParms __attribute__ ((regparm (0)))\#endif' withCRs.
		 aStream cr; cr; nextPutAll: '#if !defined(NoDbgRegParms)\# define NoDbgRegParms /*empty*/\#endif' withCRs.
		 aStream cr; cr].
	exporting := false.
	(methodList select: [:m| m isRealMethod]) do:
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
		aStream nextPut: $; ; cr].
	exporting ifTrue: [aStream nextPutAll: '#pragma export off'; cr].
	aStream cr