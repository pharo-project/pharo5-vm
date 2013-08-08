geometry
extent: newExtent
	super image: (Form extent: newExtent depth: Display depth).
	lastX := -1.
	columnForm := Form extent: (32//image depth)@(image height) depth: image depth.
	pixValMap := ((1 to: 256) collect:
			[:i | columnForm pixelValueFor: (Color gray: (256-i)/255.0)])
		as: Bitmap.
