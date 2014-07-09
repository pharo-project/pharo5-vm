mailing
mailReport: aText
	| msg |
	msg := MailMessage new
			setField: 'from' toString: 'eliot@teleplace.com';
			setField: 'to' toString: destination;
			setField: 'subject' toString:	'Customer VM Crashes ',
										(startDate date printFormat: #(3 2 1 $/ 1 2)),
										' - ',
										((endDate - 1 seconds) date printFormat: #(3 2 1 $/ 1 2));
			body: (MIMEDocument contentType: 'text/plain' content: aText asString).
	SMTPClient
		deliverMailFrom: msg from
		to: (Array with: msg to)
		text: msg text
		usingServer: MailComposition new smtpServer