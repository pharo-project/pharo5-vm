private
makeRectFromPoints
	self point2Get at: 0 put: (self point3Get at: 0).
	self point2Get at: 1 put: (self point1Get at: 1).
	self point4Get at: 0 put: (self point1Get at: 0).
	self point4Get at: 1 put: (self point3Get at: 1).