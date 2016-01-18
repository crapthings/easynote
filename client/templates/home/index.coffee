#

_ = lodash

#

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
