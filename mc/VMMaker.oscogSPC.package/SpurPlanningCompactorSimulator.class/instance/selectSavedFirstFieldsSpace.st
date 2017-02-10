space management
selectSavedFirstFieldsSpace
	"Override to make savedFirstFieldsSpace small enough for multi-pass compaction, if desired (for testing)."
	super selectSavedFirstFieldsSpace.
	"testRandomAssortment: et al create 1000 objects, aboput 5% pnned and about 33% reclaimable.  Sp 512 objects should force multi-pass."
	sffsMode == #multiPass ifTrue:
		[savedFirstFieldsSpace limit: savedFirstFieldsSpace start + (512 * manager bytesPerOop).
		 biasForGC := false]