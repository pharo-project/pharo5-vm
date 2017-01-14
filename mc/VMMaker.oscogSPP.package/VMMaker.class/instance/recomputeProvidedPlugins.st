UI access
recomputeProvidedPlugins
	allPlugins := self providedPlugins reject: [:p| (internalPlugins includes: p) or: [externalPlugins includes: p]]