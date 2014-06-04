compaction - analysis
abstractPigCompaction
	"This method answers a rough estimate of compactibility using a pig (a large free chunk)."
	<doNotGenerate>
	| pig pork moved unmoved nmoved nunmoved |
	pig := self findAPig.
	pork := self bytesInObject: pig.
	moved := unmoved := nmoved := nunmoved := 0.
	self allOldSpaceObjectsFrom: pig do:
		[:o| | bytes |
		bytes := self bytesInObject: o.
		bytes <= pork
			ifTrue:
				[moved := moved + bytes.
				 nmoved := nmoved + 1.
				 pork := pork - bytes]
			ifFalse:
				[unmoved := unmoved + bytes.
				 nunmoved := nunmoved + 1]].
	^{ self bytesInObject: pig. pork. moved. nmoved. unmoved. nunmoved }