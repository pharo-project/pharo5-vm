android template generation
setupAndroidRessources
	(ressourceDir / 'values') ensureCreateDirectory.
	self generateValuesStringXml.
	(ressourceDir / 'layout-xlarge-land/') ensureCreateDirectory.
	self generateLayoutXLargeLandXml.
	(ressourceDir / 'layout-xlarge/') ensureCreateDirectory.
	self generateLayoutXLargeXml.
	(ressourceDir / 'layout-sw720dp/') ensureCreateDirectory.
	self generateLayoutSw720dpXml.
	(ressourceDir / 'layout-sw600dp/') ensureCreateDirectory.
	self generateLayoutSw600dpXml.
	(ressourceDir / 'layout-large/') ensureCreateDirectory.
	self generateLayoutLargeXml.
	(ressourceDir / 'layout/') ensureCreateDirectory.
	self generateLayoutXml.
	drawableDir := (ressourceDir / 'drawable/') ensureCreateDirectory.
	self downloadDrawableRessources.