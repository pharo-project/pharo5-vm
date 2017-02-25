accessing
offset
	"Answer the value of offset"
	self assert: (type = SSBaseOffset or: [type = SSSpill]).
	^offset