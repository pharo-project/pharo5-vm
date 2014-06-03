submorphs - squeakJS
contextPanel
	"This should show the currentContext and Special Objects array. as seen at SqueakJS
	  Doing that requires real talent. talent tty is lacking at the moment
							on: [ Array with:  (MorphWithSubmorphsWrapper with: self)  ]	
	Array with: (ObjectExplorerWrapper with: rootObject name: 'root' model: self parent: nil)
	"
	^contextPanel ifNil: 
		[contextPanel := (SimpleHierarchicalListMorph
							on: [ Array with: (ObjectExplorerWrapper with: (self model vm) name: 'root' model: (self model vm) parent: nil) ]
							list: #value
							selected: nil
							changeSelected: nil
							menu: nil
							keystroke: nil) showScrollBarsOnlyWhenNeeded: true.
		contextPanel		
			color: Color transparent;
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			cellInset: 5;
			yourself]


