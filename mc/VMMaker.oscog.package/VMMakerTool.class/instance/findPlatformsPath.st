path access
findPlatformsPath
	| dir |
	dir := FileList2 modalFolderSelector.
	dir ifNil: [^nil].
	self platformsPathText: dir pathName