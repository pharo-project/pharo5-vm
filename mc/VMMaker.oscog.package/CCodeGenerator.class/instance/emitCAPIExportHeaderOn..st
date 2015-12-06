C code generator
emitCAPIExportHeaderOn: aStream 
	"Store prototype declarations for all non-inlined methods on the given stream."
	| api methodList usedConstants |
	api := (vmClass translationClass exportAPISelectors: self options).
	methodList := api
					select:
						[:s|
						(methods includesKey: s)
						or: [(vmClass whichClassIncludesSelector: s)
								ifNil: [false]
								ifNotNil: [:c|self shouldIncludeMethodFor: c selector: s]]]
					thenCollect:
						[:s|
						methods
							at: s
							ifAbsent: [self compileToTMethodSelector: s
										   in: (vmClass whichClassIncludesSelector: s)]].
	methodList := self sortMethods: methodList.
	methodList do:
		[:m|
		m static ifTrue:
			[logger ensureCr; show: m selector, ' excluded from export API because it is static'; cr]].
	self emitCFunctionPrototypes: methodList on: aStream.
	self emitGlobalCVariablesOn: aStream.
	usedConstants := self emitCMacros: methodList on: aStream.
	self emitCConstants: usedConstants on: aStream