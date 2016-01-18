_ = lodash

#

@Cashiers = new Mongo.Collection 'cashiers'

#

@cashiersSchema =

	no1:
		type: String
		label: '凭证编号'
		index: 1
		unique: true

	no2:
		type: String
		label: '出纳编号'
		index: 1
		unique: true

	type:
		type: String
		label: '流入流出'
		allowedValues: ['流入', '流出']
		index: 1
		autoform:
			type: 'select-radio-inline'

	source:
		type: String
		label: '资金类型'
		allowedValues: ['库存现金', '银行存款', '转账支票']
		index: 1
		autoform:
			type: 'select-radio-inline'

	account:
		type: String
		label: '账户'
		allowedValues: ['金阳', '市场', '物业', '三合']
		index: 1
		autoform:
			type: 'select-radio-inline'

	bank:
		type: String
		label: '银行'
		allowedValues: [
			'工商银行'
			'农业银行'
			'中国银行'
			'建设银行'
			'交通银行'
			'哈尔滨银行'
			'国家开发银行'
			'锦州银行'
			'内蒙古银行'
		]
		index: 1
		optional: true
		autoform:
			type: 'select-radio-inline'

	actualDate:
		type: Date
		label: '流动日期'
		index: 1
		defaultValue: new Date()
		autoform:
			afFieldInput:
				type: 'bootstrap-datepicker'

	title:
		type: String
		label: '项目名称'
		index: 1

	amount:
		type: Number
		label: '金额'

	memo:
		type: String
		label: '备注'
		index: 1
		optional: true
		autoform:
			rows: 5

	createdAt:
		type: Date
		index: 1
		autoValue: ->
			new Date()

#

Cashiers.attachSchema new SimpleSchema cashiersSchema

#

Cashiers.after.insert (userId, doc) ->
	if doc.type is '流入'
		System.update { init: true },
			$inc:
				'statistics.totalAmountIncoming': doc.amount

	if doc.type is '流出'
		System.update { init: true },
			$inc:
				'statistics.totalAmountOutcoming': doc.amount

#

Cashiers.table = new Tabular.Table

	name: 'cashiers'

	collection: Cashiers

	order: [[6, "asc"]]

	columns: [
		{ data: 'no1', title: '凭证编号' }
		{ data: 'no2', title: '出纳编号' }
		{
			data: 'type'
			title: '流入流出'
			render: (val, type, doc) ->
				if val is '流入'
					"<span class='label label-danger'>#{val}</span>"
				else
					"<span class='label label-info'>#{val}</span>"

		}
		{ data: 'source', title: '资金类型' }
		{ data: 'account', title: '账户' }
		{ data: 'bank', title: '银行' }
		{
			data: 'actualDate'
			title: '日期'
			render: (val, type, doc) ->
				moment(new Date val).format 'YYYY.MM.DD'
		}
		{ data: 'title', title: '项目名称' }
		{
			data: 'amount'
			title: cashiersSchema.amount.label
			render: (val, type, doc) -> "￥#{val.format(2)}"
		}
	]

	searchDelay: 150

	autoWidth: false

	paging: false

	footerCallback: (tfoot, data, start, end, display) ->

		totalAmountIncoming = 0

		totalAmountIncoming = _.sumBy data, (d) ->
			return d.amount if d.type is '流入'

		Session.set 'totalAmountIncoming', totalAmountIncoming

		totalAmountOutcoming = 0

		totalAmountOutcoming = _.sumBy data, (d) ->
			return d.amount if d.type is '流出'

		Session.set 'totalAmountOutcoming', totalAmountOutcoming

	language:
		info: '_TOTAL_ 条记录'
		infoEmpty: '无记录'
		processing: '读取中。。。'
		search: ''
		searchPlaceholder: '搜索'
		zeroRecords: '无记录'

#

Meteor.methods

	removeCashier: (id) ->
		Cashiers.remove id

#


Cashiers.findCashiers = (selector, options) ->

	if Meteor.isClient

		_selector =
			actualDate:
				$gte: moment(new Date(Session.get 'start')).startOf('month').toDate()
				$lte: moment(new Date(Session.get 'end')).endOf('month').toDate()

		_options =
			sort:
				createdAt: 1

		console.log Cashiers.find(_selector, _options).fetch()

		Cashiers.find _selector, _options
