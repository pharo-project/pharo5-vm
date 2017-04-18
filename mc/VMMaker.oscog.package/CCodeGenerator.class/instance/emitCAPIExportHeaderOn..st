C code generator
emitCAPIExportHeaderOn: aStream 
	"Store prototype declarations for all API methods on the given stream."
	| exportedAPIMethods usedConstants |
	exportedAPIMethods := self sortMethods: (methods select: [:m| m isAPIMethod]).
	exportedAPIMethods do:
		[:m|
		m static ifTrue:
			[logger ensureCr; show: m selector, ' excluded from export API because it is static'; cr]].
	self emitCFunctionPrototypes: exportedAPIMethods on: aStream.
	self emitGlobalCVariablesOn: aStream.
	usedConstants := self emitCMacros: exportedAPIMethods on: aStream.
	self emitCConstants: usedConstants on: aStream