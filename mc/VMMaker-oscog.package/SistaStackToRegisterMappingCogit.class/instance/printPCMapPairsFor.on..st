method map
printPCMapPairsFor: cogMethod on: aStream
	<doNotGenerate>
	(self subMethodsAsRangesFor: cogMethod)
		do: [:sm|
			self mapFor: sm cogMethod bcpc: sm startpc performUntil: #print:Mcpc:Bcpc:on: arg: aStream]
		separatedBy: [aStream tab; next: 2 put: $=; cr]