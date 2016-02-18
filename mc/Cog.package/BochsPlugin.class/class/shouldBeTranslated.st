translation
shouldBeTranslated
	"Is this class intended to be translated as a plugin, perhaps specific to a platform?
	 Most subclasses should answer true, but some such as simulation-only versions
	 should answer false for various reasons."
	^super shouldBeTranslated and: [self ~~ BochsPlugin]