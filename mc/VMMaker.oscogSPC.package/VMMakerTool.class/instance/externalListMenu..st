menus
externalListMenu: aMenu

	aMenu addTranslatedList:#(
			('make all external'						makeAllPluginsExternal)
			('make all internal'						makeAllPluginsInternal)
			('make all available'					makeAllPluginsAvailable)
			-
			('browse plugin' 						browseSelectedExternalPlugin)
			-
			('generate plugin'						generateSelectedExternalPlugin)).
	^ aMenu