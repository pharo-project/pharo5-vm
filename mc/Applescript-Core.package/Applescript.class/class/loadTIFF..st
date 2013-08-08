sample scripts
loadTIFF: unixFilename
	"Needs sips so only works in MacOSX,
	This version use unix names
		|tif| 
		tif := Applescript loadTIFF: '/Library/Audio/MIDI Devices/Generic/Images/Mixer.tiff'.
		(SketchMorph withForm: tif) openInWorld.
	"
	| til  |
	til := ByteString value: 39.
	"sips -s format png /Path/To/Icon.icns --out /Path/To/ConvertedImage.png"
	Applescript doIt: 
'do shell script "sips -s format png ', til, unixFilename, til, ' --out /tmp/auxtiff2png.png"'.
	^ImageReadWriter formFromFileNamed: '/tmp/auxtiff2png.png'
