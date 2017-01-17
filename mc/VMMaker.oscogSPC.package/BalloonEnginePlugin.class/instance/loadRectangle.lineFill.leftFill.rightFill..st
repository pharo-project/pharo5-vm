lines-loading
loadRectangle: lineWidth lineFill: lineFill leftFill: leftFill rightFill: rightFill
	"Load a rectangle currently defined by point1-point4"

	self loadWideLine: lineWidth from: self point1Get to: self point2Get
		lineFill: lineFill leftFill: leftFill rightFill: rightFill.
	self loadWideLine: lineWidth from: self point2Get to: self point3Get
		lineFill: lineFill leftFill: leftFill rightFill: rightFill.
	self loadWideLine: lineWidth from: self point3Get to: self point4Get
		lineFill: lineFill leftFill: leftFill rightFill: rightFill.
	self loadWideLine: lineWidth from: self point4Get to: self point1Get
		lineFill: lineFill leftFill: leftFill rightFill: rightFill.
