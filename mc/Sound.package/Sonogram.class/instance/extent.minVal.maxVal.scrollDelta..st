all
extent: extent minVal: min maxVal: max scrollDelta: d
	minVal := min.
	maxVal := max.
	scrollDelta := d.
	self extent: extent.

" try following with scrolldelta = 1, 20, 200
	| s data |
	s := Sonogram new extent: 200@50
				minVal: 0.0 maxVal: 1.0 scrollDelta: 20.
	World addMorph: s.
	data := (1 to: 133) collect: [:i | 0.0].
	1 to: 300 do:
		[:i | data at: (i\\133)+1 put: 1.0.
		s plotColumn: data.
		data at: (i\\133)+1 put: 0.0.
		World doOneCycleNow].
	s delete	
"