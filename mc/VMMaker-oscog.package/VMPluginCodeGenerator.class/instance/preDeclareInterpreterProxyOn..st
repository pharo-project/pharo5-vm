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
	| pluginsToClone |
	(pluginsToClone := self pluginFunctionsToClone) isEmpty ifTrue:
		[^super preDeclareInterpreterProxyOn: aStream].
	aStream cr; nextPutAll: '#if !defined(SQUEAK_BUILTIN_PLUGIN)'; cr.
	pluginsToClone do:
		[:selector| | functionName |
		functionName := self cFunctionNameFor: selector.
		aStream nextPutAll:
			((String streamContents:
				[:s|
				(self compileToTMethodSelector: selector in: InterpreterProxy)
					emitCFunctionPrototype: s generator: self])
				copyReplaceAll: functionName
				with: '(*', functionName, ')').
		aStream nextPut: $;; cr].
	aStream nextPutAll: '#else /* !defined(SQUEAK_BUILTIN_PLUGIN) */'; cr.
	pluginsToClone do:
		[:selector|
		aStream nextPutAll: 'extern '.
		(self compileToTMethodSelector: selector in: InterpreterProxy)
			static: false;
			emitCFunctionPrototype: aStream generator: self.
		aStream nextPut: $;; cr].
	aStream cr; nextPutAll: 'extern'.
	aStream cr; nextPutAll: '#endif'; cr