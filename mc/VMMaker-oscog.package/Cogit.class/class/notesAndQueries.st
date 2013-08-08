documentation
notesAndQueries
	"Mitigating cost of bytecode to machinecode pc mapping.
		HPS's scheme is to allow contexts to contain machine-code pcs in the form of negative pc values.
		This is reified at the image level and relevant accessors must check before accessing the pc.

		We hide a similar scheme entirely within the VM.  When a spouse context of a machine-code
		frame is divorced we set its pc to the negative machine-code pc.  All accesses to the instruction
		pointer of a stable context are checked (in instVar:ofContext: and externalInstVar:ofContext:).
		If the value is negative we look for, and if not found, compile the context's method and map the
		negative pc.

		The downside of this scheme is on snapshot having to trawl through the entire image looking for
		single contexts with negative pcs and mapping them to proper bytecode pcs.  But this is a minor
		inconvenience since we scan anyway to divorce or widow married contexts."