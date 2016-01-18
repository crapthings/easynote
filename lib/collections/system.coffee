#

@System = new Mongo.Collection 'system'

#

Meteor.methods

	updateTotalAmountIncoming: (opt) ->
		System.update { init: true },
			$inc:
				'statistics.totalAmountIncoming': opt

	updateTotalAmountOutcoming: (opt) ->
		System.update { init: true },
			$inc:
				'statistics.totalAmountOutcoming': opt

#

if Meteor.isClient

	Template.registerHelper 'system', ->
		System.findOne { init: true }
