@System = new Mongo.Collection 'system'

unless do System.findOne

	System.insert
		init: true

if Meteor.isClient

	Template.registerHelper 'system', ->
		System.findOne { init: true }
