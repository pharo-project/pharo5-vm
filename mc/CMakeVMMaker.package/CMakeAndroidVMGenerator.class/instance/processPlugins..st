gmake commands
processPlugins: pluginGenerators
	| libs libDeps |
	libs := OrderedCollection new.
	libDeps := Dictionary new.
	pluginGenerators do: [:gen |
		gen doNotGenerate ifFalse: [
			gen isInternal 
				ifTrue: [
					libs add: gen plugin moduleName ]
				ifFalse: [
					"make main module to depend on external plugin, just to make sure it is built 
					 before main module built"
					 ].
				gen externalDependencies 
					ifNotEmpty: [ :deps |
						libDeps 
							at: gen plugin moduleName
							put: (deps fold: [ :a :b | a, ' ', b ]) ].
			self includePlugin: gen plugin moduleName ] ].
	self generateExportsH: libs.
	