compaction - analysis
findAPig
	"Answer a large low free chuink."
	<doNotGenerate>
	| pig |
	self allObjectsInFreeTreeDo:
		[:f|
		(self bytesInObject: f) >= 1000000 ifTrue:
			[(pig isNil or: [pig > f]) ifTrue:
				[pig := f]]].
	^pig