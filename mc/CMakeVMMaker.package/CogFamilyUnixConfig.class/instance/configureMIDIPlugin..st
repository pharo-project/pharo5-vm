plugin extra rules
configureMIDIPlugin: maker 
	"extra rules for MIDIPlugin"

	super configureMIDIPlugin: maker.  

	"requires ALSA"

	maker addPlatformSources: #( 'sqUnixMIDI')