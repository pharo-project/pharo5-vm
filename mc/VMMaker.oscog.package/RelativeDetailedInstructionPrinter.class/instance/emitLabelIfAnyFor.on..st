printing
emitLabelIfAnyFor: pc on: aStream
	saveLabel := String streamContents: [:s| super emitLabelIfAnyFor: pc on: s]