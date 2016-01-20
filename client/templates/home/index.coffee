#

_ = lodash

#

Session.set 'startDate', moment(new Date()).startOf('month').toDate()
Session.set 'endDate', moment(new Date()).endOf('month').toDate()

Session.set 'selectDay', moment().startOf('day').toDate()
Session.set 'selectMonth', moment().startOf('month').toDate()
Session.set 'selectYear', moment().startOf('year').toDate()

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

Template.homeActionBar.onRendered ->

	$('#dateRangePicker').daterangepicker
		linkedCalendars: false
		autoUpdateInput: true
		autoApply: true
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
		locale:
			format: 'YYYY.MM.DD'
			separator: '/'
			applyLabel: '确定'
			cancelLabel: '取消'
			customRangeLabel: '自选'
			firstDay: 1
			monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
			daysOfWeek: ['日', '一', '二', '三', '四', '五','六']
	, (start, end) ->
		console.log start, end
		Session.set 'startDate', start.toDate()
		Session.set 'endDate', end.toDate()

Template.homeActionBar.events

	'click .method-reset-day': (e, t) ->
		do e.preventDefault
		Session.set 'selectDay', moment().toDate()
		start = moment(Session.get 'selectDay').startOf('day')
		end = moment(Session.get 'selectDay').endOf('day')
		Session.set 'startDate', start.toDate()
		Session.set 'endDate', end.toDate()
		($ '#dateRangePicker').data('daterangepicker').setStartDate(start.format('YYYY.MM.DD'))
		($ '#dateRangePicker').data('daterangepicker').setEndDate(end.format('YYYY.MM.DD'))

	'click .method-prev-day': (e, t) ->
		do e.preventDefault
		Session.set 'selectDay', moment(Session.get 'selectDay').subtract(1, 'days').toDate()
		start = moment(Session.get 'selectDay').startOf('day')
		end = moment(Session.get 'selectDay').endOf('day')
		Session.set 'startDate', start.toDate()
		Session.set 'endDate', end.toDate()
		($ '#dateRangePicker').data('daterangepicker').setStartDate(start.format('YYYY.MM.DD'))
		($ '#dateRangePicker').data('daterangepicker').setEndDate(end.format('YYYY.MM.DD'))

	'click .method-next-day': (e, t) ->
		do e.preventDefault
		Session.set 'selectDay', moment(Session.get 'selectDay').add(1, 'days').toDate()
		start = moment(Session.get 'selectDay').startOf('day')
		end = moment(Session.get 'selectDay').endOf('day')
		Session.set 'startDate', start.toDate()
		Session.set 'endDate', end.toDate()
		($ '#dateRangePicker').data('daterangepicker').setStartDate(start.format('YYYY.MM.DD'))
		($ '#dateRangePicker').data('daterangepicker').setEndDate(end.format('YYYY.MM.DD'))

	'click .method-reset-month': (e, t) ->
		do e.preventDefault
		Session.set 'selectMonth', moment().toDate()
		start = moment(Session.get 'selectMonth').startOf('month')
		end = moment(Session.get 'selectMonth').endOf('month')
		Session.set 'startDate', start.toDate()
		Session.set 'endDate', end.toDate()
		($ '#dateRangePicker').data('daterangepicker').setStartDate(start.format('YYYY.MM.DD'))
		($ '#dateRangePicker').data('daterangepicker').setEndDate(end.format('YYYY.MM.DD'))

	'click .method-prev-month': (e, t) ->
		do e.preventDefault
		Session.set 'selectMonth', moment(Session.get 'selectMonth').subtract(1, 'months').toDate()
		start = moment(Session.get 'selectMonth').startOf('month')
		end = moment(Session.get 'selectMonth').endOf('month')
		Session.set 'startDate', start.toDate()
		Session.set 'endDate', end.toDate()
		($ '#dateRangePicker').data('daterangepicker').setStartDate(start.format('YYYY.MM.DD'))
		($ '#dateRangePicker').data('daterangepicker').setEndDate(end.format('YYYY.MM.DD'))

	'click .method-next-month': (e, t) ->
		do e.preventDefault
		Session.set 'selectMonth', moment(Session.get 'selectMonth').add(1, 'months').toDate()
		start = moment(Session.get 'selectMonth').startOf('month')
		end = moment(Session.get 'selectMonth').endOf('month')
		Session.set 'startDate', start.toDate()
		Session.set 'endDate', end.toDate()
		($ '#dateRangePicker').data('daterangepicker').setStartDate(start.format('YYYY.MM.DD'))
		($ '#dateRangePicker').data('daterangepicker').setEndDate(end.format('YYYY.MM.DD'))

	'click .method-reset-year': (e, t) ->
		do e.preventDefault
		Session.set 'selectYear', moment().toDate()
		start = moment(Session.get 'selectYear').startOf('year')
		end = moment(Session.get 'selectYear').endOf('year')
		Session.set 'startDate', start.toDate()
		Session.set 'endDate', end.toDate()
		($ '#dateRangePicker').data('daterangepicker').setStartDate(start.format('YYYY.MM.DD'))
		($ '#dateRangePicker').data('daterangepicker').setEndDate(end.format('YYYY.MM.DD'))

	'click .method-prev-year': (e, t) ->
		do e.preventDefault
		Session.set 'selectYear', moment(Session.get 'selectYear').subtract(1, 'years').toDate()
		start = moment(Session.get 'selectYear').startOf('year')
		end = moment(Session.get 'selectYear').endOf('year')
		Session.set 'startDate', start.toDate()
		Session.set 'endDate', end.toDate()
		($ '#dateRangePicker').data('daterangepicker').setStartDate(start.format('YYYY.MM.DD'))
		($ '#dateRangePicker').data('daterangepicker').setEndDate(end.format('YYYY.MM.DD'))

	'click .method-next-year': (e, t) ->
		do e.preventDefault
		Session.set 'selectYear', moment(Session.get 'selectYear').add(1, 'years').toDate()
		start = moment(Session.get 'selectYear').startOf('year')
		end = moment(Session.get 'selectYear').endOf('year')
		Session.set 'startDate', start.toDate()
		Session.set 'endDate', end.toDate()
		($ '#dateRangePicker').data('daterangepicker').setStartDate(start.format('YYYY.MM.DD'))
		($ '#dateRangePicker').data('daterangepicker').setEndDate(end.format('YYYY.MM.DD'))
