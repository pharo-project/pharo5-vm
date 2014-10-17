reporting
reportCrashRates: count
	{ soloTime. meetingTime }
		with: #('solo hours: ' 'meeting hours: ')
		do: [:time :label|
			rs	nextPutAll: label; print: (time asSeconds / SecondsInHour) rounded;
				space; nextPut: $(; print: time; nextPut: $); cr].
	rs cr.
	{ soloTime. meetingTime }
		with: #('solo' 'meeting')
		do: [:time :label|
			{ SecondsInHour. SecondsInDay }
				with: #('hour' 'day')
				do: [:period :periodLabel| | rate |
					rate := count / (time asSeconds / period).
					rs	print: (rate roundTo: (rate >= 1 ifTrue: [0.1] ifFalse: [0.001]));
						nextPutAll: ' crashes per '; nextPutAll: label; space; nextPutAll: periodLabel; cr]].
	rs cr; cr