plugin extra rules
configureMIDIPlugin: maker 
	"extra rules for MIDIPlugin"

	super configureMIDIPlugin: maker.  
	maker addPlatformSources: #( 'sqMacMIDI.c')