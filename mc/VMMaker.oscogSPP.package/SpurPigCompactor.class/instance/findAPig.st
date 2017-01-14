compaction - analysis
findAPig
	"Answer a large low free chunk."
	<doNotGenerate>
	| pig |
	manager allObjectsInFreeTreeDo:
		[:f|
		(manager bytesInObject: f) >= 1000000 ifTrue:
			[(pig isNil or: [pig > f]) ifTrue:
				[pig := f]]].
	^pig