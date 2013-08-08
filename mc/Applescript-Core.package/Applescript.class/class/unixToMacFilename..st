sample scripts
unixToMacFilename: unixname
	"Convert filename
		Applescript unixToMacFilename: '/Library/Audio/MIDI Devices/Generic/Images/Mixer.tiff'	
	"
	| macName s |
	s := 'POSIX file "' , unixname, '"'.
	macName := Applescript doIt: s.
	^ (macName findTokens: '"') at: 2.