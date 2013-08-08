header access
sizeHeader: oop

	^ self longAt: oop - (BytesPerWord*2)