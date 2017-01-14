utilities
generatePluginsTo: srcDirName options: optionsPairsArray platformDir: platDirName including: inclusions
	"Generate the plugins to the given target directory. Include only plugins in pluginList."
	(self
		makerFor: StackInterpreter
		and: nil
		with: optionsPairsArray
		to: srcDirName
		platformDir: platDirName
		including: inclusions) generatePlugins