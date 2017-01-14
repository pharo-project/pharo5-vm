inlining
reportShouldNotBeRemoved: removed varList: varList
	"Report whether any of the removed methods are still used."
	| varListAsStrings shouldNotBeRemoved |
	varListAsStrings := varList collect: [ :sym | sym asString ].
	shouldNotBeRemoved := Set new.
	removed do:
		[:m|
		m isAPIMethod ifTrue:
			[shouldNotBeRemoved add: m selector]].
	methods do:
		[:m|
		(m selector = #interpret
		 or: [removed includes: m selector]) ifFalse:
			[m allCalls do:
				[:sel|
				(removed includesKey: sel) ifTrue:
					[shouldNotBeRemoved add: sel]]]].
	vmClass additionalSelectorTables do:
		[:selectorTable|
		 selectorTable do:
			[:selOrInteger|
			selOrInteger isInteger ifFalse:
				[(removed includesKey: selOrInteger) ifTrue:
					[shouldNotBeRemoved add: selOrInteger]]]].
	shouldNotBeRemoved do:
		[:sel| | str |
		str := String streamContents:
				[:strm| | them |
				strm
					nextPutAll: 'Removed ';
					nextPutAll: sel;
					nextPutAll: ' because it refers to the local variable'.
				them := (removed at: sel) freeVariableReferences asSet intersection: varListAsStrings.
				them size > 1 ifTrue:
					[strm nextPut: $s.
					 them := self sortStrings: them].
				them do: [:var| strm space; nextPutAll: var].

				strm
					nextPutAll: ' of interpret.';
					cr;
					nextPutAll: 'But it is either used outside of interpret or exported!!';
					cr].
		logger ensureCr; show: str.
		self inform: str]