processing plugins
processPlugins: pluginGenerators
	| libs libDeps |

	libs := OrderedCollection new.
	libDeps := Dictionary new.
	pluginGenerators do: [:gen |
		gen doNotGenerate ifFalse: [
			gen isInternal 
				ifTrue: [
					libs add: gen plugin moduleExportsName ]
				ifFalse: [
					"make main module to depend on external plugin, just to make sure it is built 
					 before main module built"
					self 
						cmd: 'add_dependencies' 
						params: config executableName, ' ' , gen plugin moduleName ].
				gen externalDependencies 
					ifNotEmpty: [ :deps |
						libDeps 
							at: gen plugin moduleName
							put: (deps fold: [ :a :b | a, ' ', b ]) ].
			self addSubdirectory: gen plugin moduleName ] ].

	self cmd: 'target_link_libraries' params:  config executableName , ' ' ,
		(libs inject: '' into: [:res :ea | res, ' ' , ea ]).

	libDeps keysAndValuesDo: [ :moduleName :dependencies |
		self 
			cmd: 'add_dependencies' 
			params: moduleName, ' ', dependencies ].  

	self generateExportsH: libs.