*SpurVMMakerPharoCompatibility
codeForNoSource
	"this is the marker we use for method that have no source. 
	 I'm keeping the old non-decompiled version to avoid all the decompile process (who is having some bootstrap problems)"
	^String streamContents: [:str |
			str 
				nextPutAll: self selector asMethodPreamble;
				cr;tab;
				nextPutAll: 'self flag: #methodHasNoSourceCode'].