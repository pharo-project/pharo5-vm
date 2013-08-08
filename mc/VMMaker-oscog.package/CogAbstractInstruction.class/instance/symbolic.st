printing
symbolic
	<doNotGenerate> "Smalltalk-side only"
	^String streamContents: [:s| self symbolicOn: s]