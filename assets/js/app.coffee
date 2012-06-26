#= require vendor/jquery
#= require vendor/bootstrap

#= require models/Application
#= require models/Query
#= require routers/Router

#= require views/QueryView
#= require views/ProfileView
#= require views/ContextView

@OAQ = window.OAQ ? {}

$ ->
  application = OAQ.app = new OAQ.Application()

  new OAQ.QueryView
    model: application
    propertyName: 'savedQueries'
    el: ($ '#x-saved-query-tree')

  new OAQ.QueryView
    model: application
    propertyName: 'adhocQueries'
    el: ($ '#x-adhoc-query-tree')

  new OAQ.ProfileView
    model: application
    el: ($ '#x-profile-info')

  new OAQ.ContextView
    model: application
    el: ($ '#x-current-context')

  ($ '.form-search').on 'submit', (e) ->
    criteria = ($ '.search-query').val()
    encodedCriteria = encodeURIComponent criteria
    query = new OAQ.Query
      _id: encodedCriteria
      criteria: criteria
      label: _.map(criteria.split(/\s+/), (m)->"«#{m}»").join(' ET ')
    application.get('adhocQueries').add(query)
    query.execute
      success: (results) ->
        application.set('currentQuery', query)
        OAQ.router.navigate "dossiers/#{results.first().id}", {trigger:yes}
    no # propagation

  ($ '#x-profile-nav-next').on 'click', ->
    application.moveToNextDossier()

  ($ '#x-profile-nav-prev').on 'click', ->
    application.moveToPrevDossier()

  OAQ.router = new OAQ.Router()
  Backbone.history.start()
