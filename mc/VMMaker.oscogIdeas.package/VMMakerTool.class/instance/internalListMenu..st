menus
internalListMenu: aMenu

	aMenu addTranslatedList:#(
			('make all external'						makeAllPluginsExternal)
			('make all internal'						makeAllPluginsInternal)
			('make all available'					makeAllPluginsAvailable)
			-
			('browse plugin' 						browseSelectedInternalPlugin)
			-
			('generate plugin'						generateSelectedInternalPlugin)).
	^ aMenu