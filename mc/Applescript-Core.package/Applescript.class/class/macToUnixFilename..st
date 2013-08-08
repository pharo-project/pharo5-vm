sample scripts
macToUnixFilename: macname
	"Convert filename
		Applescript macToUnixFilename: 'Macintosh HD:Library:Audio:MIDI Devices:Generic:Images:Mixer.tiff'
	"
	| unixFilename |
	unixFilename := Applescript doIt: 'POSIX path of file "', macname, '"'.
	^ (unixFilename findTokens: '"') at: 1.
