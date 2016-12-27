C code generator
emitCAPIExportHeaderOn: aStream 
	"Store prototype declarations for all non-inlined methods on the given stream."
	| apiMethods usedConstants |
	apiMethods := self sortMethods: (methods select: [:m| m isAPIMethod]).
	apiMethods do:
		[:m|
		m static ifTrue:
			[logger ensureCr; show: m selector, ' excluded from export API because it is static'; cr]].
	self emitCFunctionPrototypes: apiMethods on: aStream.
	self emitGlobalCVariablesOn: aStream.
	usedConstants := self emitCMacros: apiMethods on: aStream.
	self emitCConstants: usedConstants on: aStream