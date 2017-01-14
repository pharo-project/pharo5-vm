utilities
preenImage
	"Assume there's a Pharo bootstrap core32.image in ../oscogvm/image/core32.image.
	 We should find out where the image directory is and write a download script to get it.
	 But for now assume it's there."
	"[SpurPlanningCompactorTests preenImage] timeToRun"
	Spur32BitPreen new
		writeDefaultHeader: true;
		savedWindowSize: 640@480;
		preenImage: '../oscogvm/image/core32'