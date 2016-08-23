path access
findPlatformsPathFrom: fd
	| path |
	Utilities informUserDuring:[:bar|
		path := self findPlatformsPathFrom: fd informing: bar.
	].
	^path