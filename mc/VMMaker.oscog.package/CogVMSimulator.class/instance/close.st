initialization
close  "close any files that ST may have opened, etc"
	pluginList do: [:plugin| (plugin ~~ self and: [plugin respondsTo: #close]) ifTrue: [plugin close]]