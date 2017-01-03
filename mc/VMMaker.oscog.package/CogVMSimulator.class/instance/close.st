initialization
close  "close any files that ST may have opened, etc"
	pluginList do: [:assoc| | plugin | plugin := assoc value. plugin ~~ self ifTrue: [plugin close]]