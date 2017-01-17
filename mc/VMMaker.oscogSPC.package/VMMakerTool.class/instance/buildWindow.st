window construction
buildWindow
	"VMMakerTool openInWorld"
	| sysWin box verticalOffset |
	sysWin := (SystemWindow labelled: 'VMMaker')
				model: self.
	verticalOffset := self addTopButtonRowToWindow: sysWin.
	verticalOffset := self addSecondButtonRowToWindow: sysWin startingAt: verticalOffset.
	box := self buildCenterRows.
	sysWin
		addMorph: box
		fullFrame: (LayoutFrame
				fractions: (0 @ 0 corner: 1 @ 0)
				offsets: (0 @ verticalOffset corner: 0 @ (verticalOffset := verticalOffset + box height - 1))).
	"Add the list of plugins that are available to build"
	allPluginsList := (PluggableListMorph
				on: self
				list: #availableModules
				selected: #currentAvailableModuleIndex
				changeSelected: #currentAvailableModuleIndex:
				menu: #availableListMenu:
				keystroke: nil) enableDragNDrop.
	allPluginsList hResizing: #spaceFill;
		 vResizing: #spaceFill;
		 borderWidth: 0.
	box := AlignmentMorph newColumn.
	box addMorphBack: (TextMorph new contents: 'Plugins not built' asText allBold;
			 lock);
		 setBalloonText: 'List of plugins that are available to build but not yet chosen. Drag to either other list or use menu option to move in bulk'.
	box addMorphBack: allPluginsList.
	sysWin
		addMorph: box
		fullFrame: (LayoutFrame
				fractions: (0 @ 0 corner: 1 / 3 @ 1)
				offsets: (0 @ verticalOffset corner: 0 @ -100)).
	"make the list for plugins that will be built for internal linking"
	internalPluginsList := (PluggableListMorph
				on: self
				list: #internalModules
				selected: #currentInternalModuleIndex
				changeSelected: #currentInternalModuleIndex:
				menu: #internalListMenu:
				keystroke: nil) enableDragNDrop.
	internalPluginsList hResizing: #spaceFill;
		 vResizing: #spaceFill;
		 borderWidth: 0.
	box := AlignmentMorph newColumn.
	box addMorphBack: (TextMorph new contents: 'Internal Plugins' asText allBold;
			 lock);
		 setBalloonText: 'List of plugins chosen to be built internally'.
	box addMorphBack: internalPluginsList.
	sysWin
		addMorph: box
		fullFrame: (LayoutFrame
				fractions: (1 / 3 @ 0 corner: 2 / 3 @ 1)
				offsets: (0 @ verticalOffset corner: 0 @ -100)).
	"make the list for plugins to be built externally (ie as DLLs, SO
	or 
	whatever suits the platform"
	externalPluginsList := (PluggableListMorph
				on: self
				list: #externalModules
				selected: #currentExternalModuleIndex
				changeSelected: #currentExternalModuleIndex:
				menu: #externalListMenu:
				keystroke: nil) enableDragNDrop.
	externalPluginsList hResizing: #spaceFill;
		 vResizing: #spaceFill;
		 borderWidth: 0.
	box := AlignmentMorph newColumn.
	box addMorphBack: (TextMorph new contents: 'External Plugins' asText allBold;
			 lock);
		 setBalloonText: 'List of plugins chosen to be built externally'.
	box addMorphBack: externalPluginsList.
	sysWin
		addMorph: box
		fullFrame: (LayoutFrame
				fractions: (2 / 3 @ 0 corner: 1 @ 1)
				offsets: (0 @ verticalOffset corner: 0 @ -100)).
	sysWin
		addMorph: (PluggableTextMorph
				on: logger
				text: nil
				accept: nil
				readSelection: nil
				menu: nil)
		fullFrame: (LayoutFrame
				fractions: (0 @ 1 corner: 1 @ 1)
				offsets: (0 @ -100 corner: 0 @ 0)).
	^ sysWin