helper = Template.registerHelper

helper 'getSession', (sessionName) ->
	Session.get sessionName

helper 'formatNumber', (number) -> number?.format 2

#

helper 'tables', ->
	return {
		cashiers: Cashiers.table
	}
