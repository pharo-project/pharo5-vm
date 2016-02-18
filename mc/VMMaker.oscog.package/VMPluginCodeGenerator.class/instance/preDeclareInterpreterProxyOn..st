C code generator
preDeclareInterpreterProxyOn: aStream
	"Put the necessary #defines needed before interpreterProxy.  Basically
	 internal plugins use the VM's interpreterProxy variable and external plugins
	 use their own.  Override to keep local copies of all functions in external
	 prims, and link directly in internal plugins."
	"| pcc |
	pcc := self new.
	(InterpreterProxy selectors reject: [:s| #(initialize private) includes: (InterpreterProxy whichCategoryIncludesSelector: s)]) do:
		[:s| pcc noteUsedPluginFunction: s].
	pcc preDeclareInterpreterProxyOn: Transcript.
	Transcript flush"
	| pluginFuncs interpreterClass objectMemoryClass |
	(pluginFuncs := self pluginFunctionsToClone) isEmpty ifTrue:
		[^super preDeclareInterpreterProxyOn: aStream].
	aStream cr; nextPutAll: '#if !defined(SQUEAK_BUILTIN_PLUGIN)'; cr.
	interpreterClass := self referenceInterpreterClass.
	objectMemoryClass := self referenceObjectMemoryClass.
	pluginFuncs := pluginFuncs collect:
						[:selector| | reference actual |
						reference := self compileToTMethodSelector: selector
										in: ((interpreterClass whichClassIncludesSelector: selector) ifNil:
											[(objectMemoryClass whichClassIncludesSelector: selector) ifNil:
												[InterpreterProxy]]).
						actual := self compileToTMethodSelector: selector in: InterpreterProxy.
						(reference returnType ~= actual returnType
						 or: [(1 to: reference args size) anySatisfy:
								[:i| (reference typeFor: (reference args at: i) in: self)
								  ~= (actual typeFor: (actual args at: i) in: self)]]) ifTrue:
							[self logger
								nextPutAll: 'warning, signature of InterpreterProxy>>';
								nextPutAll: selector;
								nextPutAll: ' does not match reference implementation.';
								cr].
						actual].
	pluginFuncs do:
		[:tMethod|
		 tMethod recordDeclarationsIn: self.
		 tMethod returnType ifNil:
			[tMethod inferReturnTypeIn: self]].
	
	pluginFuncs do:
		[:tMethod| self preDeclareStaticFunction: tMethod on: aStream].	
	aStream cr; nextPutAll: '#else /* !defined(SQUEAK_BUILTIN_PLUGIN) */'.
	pluginFuncs do:
		[:tMethod| self preDeclareExternFunction: tMethod on: aStream ].
	aStream cr; nextPutAll: 'extern'.
	aStream cr; nextPutAll: '#endif'; cr