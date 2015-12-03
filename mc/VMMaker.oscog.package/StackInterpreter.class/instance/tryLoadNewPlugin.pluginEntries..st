primitive support
tryLoadNewPlugin: pluginString pluginEntries: pluginEntries
	"Load the plugin and if on Spur, populate pluginEntries with the prmitives in the plugin."
	<doNotGenerate>
	| plugin realPluginClass plugins simulatorClasses |
	self transcript cr; show: 'Looking for module ', pluginString.
	"Defeat loading of the FloatArrayPlugin & Matrix2x3Plugin since complications with 32-bit
	 float support prevent simulation.  If you feel up to tackling this start by implementing
		cCoerce: value to: cType
			^cType = 'float'
				ifTrue: [value asIEEE32BitWord]
				ifFalse: [value]
	 in FloatArrayPlugin & Matrix2x3Plugin and then address the issues in the BalloonEnginePlugin.
	 See http://forum.world.st/Simulating-the-BalloonEnginePlugin-FloatArrayPlugin-amp-Matrix2x3Plugin-primitives-td4734673.html"
	(#('FloatArrayPlugin' 'Matrix2x3Plugin') includes: pluginString) ifTrue:
		[self transcript show: ' ... defeated'. ^nil].
	pluginString isEmpty
		ifTrue:
			[plugin := self]
		ifFalse:
			[plugins := InterpreterPlugin allSubclasses select: [:psc| psc moduleName asString = pluginString asString].
			simulatorClasses := (plugins
									select: [:psc| psc simulatorClass notNil]
									thenCollect: [:psc| psc simulatorClass]) asSet.
			simulatorClasses isEmpty ifTrue: [self transcript show: ' ... not found'. ^nil].
			simulatorClasses size > 1 ifTrue: [^self error: 'This won''t work...'].
			(plugins copyWithoutAll: simulatorClasses) notEmpty ifTrue:
				[plugins := plugins copyWithoutAll: simulatorClasses].
			plugins size > 1 ifTrue:
				[self transcript show: '...multiple plugin classes; choosing ', plugins last name].
			realPluginClass := plugins last. "hopefully lowest in the hierarchy..."
			plugin := simulatorClasses anyOne newFor: realPluginClass.
			plugin setInterpreter: objectMemory. "Ignore return value from setInterpreter"
			(plugin respondsTo: #initialiseModule) ifTrue:
				[plugin initialiseModule ifFalse:
					[self transcript show: ' ... initialiser failed'. ^nil]]]. "module initialiser failed"
	self transcript show: ' ... loaded'.
	objectMemory hasSpurMemoryManagerAPI ifTrue:
		[| realPlugin cg |
		 self transcript show: '...computing accessor depths'.
		 plugin class isPluginClass
			ifTrue:
				[realPlugin := (plugin isSmartSyntaxPluginSimulator
									ifTrue: [realPluginClass]
									ifFalse: [plugin class])
								 withAllSuperclasses detect: [:class| class shouldBeTranslated].
				 cg := realPlugin buildCodeGenerator]
			ifFalse:
				[cg := self codeGeneratorToComputeAccessorDepth.
				 primitiveTable withIndexDo:
					[:prim :index| | depth |
					 prim isSymbol ifTrue:
						[depth := cg accessorDepthForSelector: prim.
						 self assert: (depth isInteger or: [depth isNil and: [(plugin class whichClassIncludesSelector: prim) isNil]]).
						 primitiveAccessorDepthTable at: index - 1 put: depth]]].
		 cg exportedPrimitiveNames do:
			[:primName| | fnSymbol |
			 fnSymbol := primName asSymbol.
			 pluginEntries addLast: {plugin.
									fnSymbol.
									[plugin perform: fnSymbol. self].
									cg accessorDepthForSelector: fnSymbol}].
		 self transcript show: '...done'].
	^pluginString asString -> plugin