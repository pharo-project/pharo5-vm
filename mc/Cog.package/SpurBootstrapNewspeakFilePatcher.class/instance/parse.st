parsing
parse
	| platform |
	platform := BlackMarket platform.
	^[(NewspeakParsing
			usingPlatform: platform
			grammar: (NewspeakGrammar parserLib: (CombinatorialParsing usingPlatform: platform))
			asts: (NewspeakASTs usingLib: platform)) Parser new compilationUnit parse: source]
		ensure: [source close]