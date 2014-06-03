check installed plugin
minorNO
	| no |
	^ (no := self versionNO) ifNotNil: [no \\ 1000]
