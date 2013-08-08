user interface
buildMVCViewOn: aSyntaxError
	"Answer an MVC view on the given SyntaxError."

	| topView aListView aCodeView |
	topView := StandardSystemView new
		model: aSyntaxError;
		label: 'Applescript Error';
		minimumSize: 380@220.

	aListView := PluggableListView on: aSyntaxError
		list: #list
		selected: #listIndex
		changeSelected: nil
		menu: #listMenu:.
	aListView window: (0@0 extent: 380@20).
	topView addSubView: aListView.

	aCodeView := PluggableTextView on: aSyntaxError
		text: #contents
		accept: nil
		readSelection: #contentsSelection
		menu: #codePaneMenu:shifted:.
	aCodeView window: (0@0 extent: 380@200).
	topView addSubView: aCodeView below: aListView.

	^ topView
