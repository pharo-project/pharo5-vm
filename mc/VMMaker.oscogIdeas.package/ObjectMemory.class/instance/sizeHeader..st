header access
sizeHeader: oop

	^ self longAt: oop - (self wordSize*2)