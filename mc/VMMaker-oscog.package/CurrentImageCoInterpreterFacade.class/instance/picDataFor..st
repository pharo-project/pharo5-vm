testing
picDataFor: cogMethod
	| cm nBytes nEntries oversizeData |
	cm := cogMethod methodObject.
	nBytes := (self byteSizeOf: cm) - (self startPCOfMethod: cm).
	oversizeData := Array new: nBytes.
	nEntries := cogit picDataFor: cogMethod into: (self oopForObject: oversizeData).
	^oversizeData copyFrom: 1 to: nEntries