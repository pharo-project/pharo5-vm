accessing
srcPluginsDir
	^ srcPluginsDir ifNil: [ srcPluginsDir := self srcDir ]