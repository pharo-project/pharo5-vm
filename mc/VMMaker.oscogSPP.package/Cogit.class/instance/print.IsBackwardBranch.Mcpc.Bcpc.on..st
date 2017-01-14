method map
print: descriptor IsBackwardBranch: isBackwardBranch Mcpc: mcpc Bcpc: bcpc on: aStream
	<doNotGenerate>
	aStream ensureCr.
	mcpc printOn: aStream base: 16.
	aStream
		space; tab;
		print: (isBackwardBranch ifTrue: [bcpc] ifFalse: [bcpc + descriptor numBytes]);
		cr; flush.
	^0