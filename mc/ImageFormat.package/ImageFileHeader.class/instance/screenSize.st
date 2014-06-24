accessing
screenSize
	"World extent at the time of image save, packed into 32 bit integer when
	saved to file header."

	"right=  windowBounds.x + ((unsigned)savedWindowSize >> 16);
	bottom= windowBounds.y + (savedWindowSize & 0xFFFF);"

	^ screenSize