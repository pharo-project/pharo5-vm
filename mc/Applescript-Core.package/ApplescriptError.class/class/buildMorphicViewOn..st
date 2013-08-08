user interface
buildMorphicViewOn: aSyntaxError
	"Answer an Morphic view on the given SyntaxError."
	| window |
	window := (SystemWindow labelled: 'Applescript Error') model: aSyntaxError.

	window addMorph: (PluggableListMorph on: aSyntaxError list: #list
			selected: #listIndex changeSelected: nil menu: #listMenu:)
		frame: (0@0 corner: 1@0.15).

	window addMorph: (PluggableTextMorph on: aSyntaxError text: #contents
			accept: nil readSelection: #contentsSelection
			menu: #codePaneMenu:shifted:)
		frame: (0@0.15 corner: 1@1).

	^ window openInWorldExtent: 380@220