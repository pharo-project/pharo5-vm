accessing
structClasses: classes
	structClasses := classes.
	structClasses do:
		[:structClass| self addStructClass: structClass]