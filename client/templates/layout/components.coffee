# Template.filter.onRendered ->

# 	($ 'input[name="daterange"]').daterangepicker
# 		'showDropdowns': true
# 		'startDate': moment().startOf('month').toDate()
# 		'endDate': moment().endOf('month').toDate()
# 	, (start, end, label) ->
# 		Session.set 'start', start.format 'YYYY-MM-DD'
# 		Session.set 'end', end.format 'YYYY-MM-DD'
