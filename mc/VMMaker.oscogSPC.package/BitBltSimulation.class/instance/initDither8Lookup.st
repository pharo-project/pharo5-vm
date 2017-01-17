initialize-release
initDither8Lookup	
	<inline: false> 
	0 to: 255 do: [:b | 
		0 to: 15 do: [:t | | value |
			value := self expensiveDither32To16: b threshold: t.
			dither8Lookup at: ((t << 8)+b)put: value]].
	