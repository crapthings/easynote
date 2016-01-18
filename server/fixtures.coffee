#

_ = lodash

faker = Meteor.npmRequire 'faker'

#
System.remove {}
Cashiers.remove {}

#

Meteor.startup ->

	System.insert
		init: true

	# _.times 300, (n) ->
	# 	Cashiers.insert
	# 		no1: n
	# 		no2: n
	# 		type: _.sample cashiersSchema.type.allowedValues
	# 		source: _.sample cashiersSchema.source.allowedValues
	# 		account: _.sample cashiersSchema.account.allowedValues
	# 		bank: _.sample cashiersSchema.bank.allowedValues
	# 		actualDate: _.sample [faker.date.past(), faker.date.recent(), faker.date.future()]
	# 		title: do faker.lorem.sentence
	# 		amount: _.random 100, 100000
	# 		memo: do Random.id
