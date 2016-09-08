check installed plugin
majorNO
	| no |
	^ (no := self versionNO) ifNotNil: [no // 1000]
