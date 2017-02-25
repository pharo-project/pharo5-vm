menus
availableListMenu: aMenu

	aMenu addTranslatedList: #(
			('make all external'						makeAllPluginsExternal)
			('make all internal'						makeAllPluginsInternal)
			('make all available'					makeAllPluginsAvailable)
			-
			('browse plugin' 						browseSelectedAvailablePlugin)
			('refresh list' 							refreshAvailablePluginsList)).
	^ aMenu