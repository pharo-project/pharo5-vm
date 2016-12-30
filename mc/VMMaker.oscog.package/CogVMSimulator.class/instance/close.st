initialization
close  "close any files that ST may have opened, etc"
	pluginList do: [:plugin| plugin ~~ self ifTrue: [plugin close]]