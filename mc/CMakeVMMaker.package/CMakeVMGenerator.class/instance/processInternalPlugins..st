processing plugins
processInternalPlugins: pluginGenerators

	| libs |
	libs := OrderedCollection new.

	pluginGenerators do: [:gen |
		gen doNotGenerate ifFalse: [
			libs add:  gen plugin moduleName.
			self addSubdirectory:  gen plugin moduleName.
			 ].
		].

	self cmd: 'target_link_libraries' params:  config executableName , ' ' ,
		(libs inject: '' into: [:res :ea | res, ' ' , ea ]) .

	self generateExportsH: libs.
