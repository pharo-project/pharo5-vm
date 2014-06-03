menus
platformsListMenu
	"create a menu of all known platforms"

	| choice platnames |
	platnames := vmMaker platformRootDirectory directoryNames reject:
					[:dirName|
					dirName first = $. ".svn .git et al"
					or: [dirName ='CVS']].
	choice := (PopUpMenu labelArray: platnames lines: #()) startUp.
	choice ~= 0 ifTrue:
		[self platformNameText: (platnames at: choice) asText]