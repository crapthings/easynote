#

_ = lodash

#

Session.set 'startDate', moment(new Date()).startOf('month').toDate()
Session.set 'endDate', moment(new Date()).endOf('month').toDate()

Router.route '/', ->
	@render 'home',
		data: ->
			title: '现金流量月报表'
			cashiers: ->
				Cashiers.find {}
,
	name: 'home'
	data: ->
		title: '首页'

Template.filterResult.helpers

	totalAmountIncoming: ->
		result = Session.get 'totalAmountIncoming'
		if result
			result
		else
			result = 0

	totalAmountOutcoming: ->
		result = Session.get 'totalAmountOutcoming'
		if result
			result
		else
			result = 0

Template.home.helpers

	cashiersSelector: ->
		{
			actualDate:
				$gte: Session.get 'startDate'
				$lte: Session.get 'endDate'
		}

Template.home.onRendered ->

	$('input[name="daterange"]').daterangepicker
		startDate: Session.get 'startDate'
		endDate: Session.get 'endDate'
		showDropdowns: true
		ranges:
			'今天': [moment(), moment()]
			'昨天': [moment().subtract(1, 'days'), moment().subtract(1, 'days')]
			'当月': [moment().startOf('month'), moment().endOf('month')]
			'上月': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
			'今年': [moment().startOf('year'), moment().endOf('year')]
			'去年': [moment().subtract(1, 'year').startOf('year'), moment().subtract(1, 'year').endOf('year')]
	, (start, end) ->
		Session.set 'startDate', start.toDate()
		Session.set 'endDate', end.toDate()
