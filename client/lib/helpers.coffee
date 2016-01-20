helper = Template.registerHelper

helper 'getSession', (sessionName) ->
	Session.get sessionName

helper 'formatDateFromSession', (sessionName, format) ->
	moment(Session.get(sessionName)).format(format)

helper 'formatNumber', (number) -> number?.format 2

#

helper 'tables', ->
	return {
		cashiers: Cashiers.table
	}
