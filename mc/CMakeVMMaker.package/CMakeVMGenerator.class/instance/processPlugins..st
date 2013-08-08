processing plugins
processPlugins: pluginGenerators

	| libs |
	libs := OrderedCollection new.

	pluginGenerators do: [:gen |
		gen doNotGenerate ifFalse: [
			gen isInternal ifTrue: [
				libs add:  gen plugin moduleName ]
			ifFalse: [
				"make main module to depend on external plugin, just to make sure it is built before main module built"
				self cmd: 'add_dependencies' params: config executableName, ' ' , gen plugin moduleName
				].
			self addSubdirectory:  gen plugin moduleName.
			 ].
		].

	self cmd: 'target_link_libraries' params:  config executableName , ' ' ,
		(libs inject: '' into: [:res :ea | res, ' ' , ea ]) .

	self generateExportsH: libs.
