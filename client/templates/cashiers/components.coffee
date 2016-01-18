#

_ = lodash

#

Router.route '/cashiers/new', ->
	@render 'newCashier'
,
	name: 'newCashier'
	data: ->
		title: '增加'

#

Router.route '/cashiers/update/:_id', ->
	@cashier = Cashiers.findOne @params._id
	@render 'updateCashier',
		data: ->
			cashier: @cashier
,
	name: 'updateCashier'
	data: ->
		title: "更新 #{@cashier.title}"

#

Template.cashierItem.helpers

	typeClass: ->
		if @type is '流入'
			return 'danger'
		else
			return 'info'

#

Template.cashierItem.events

	'click .method-remove-cashier': ->
		if confirm '你确定要删除吗？'
			Meteor.call 'removeCashier', @_id

#

Template.cashierList.onRendered ->
	($ 'table').stickyTableHeaders
		fixedOffset: ($ '#ui-navbar')

#

Template.cashierTableHeadSub.helpers

	totalAmountIncoming: ->
		amount = 0
		@cashiers().forEach (d) ->
			amount += d.amount if d.type is '流入'
		return amount

	totalAmountOutcoming: ->
		amount = 0
		@cashiers().forEach (d) ->
			d.type is '流出' and
			amount += d.amount if d.type is '流出'
		return amount

