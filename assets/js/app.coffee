#= require vendor/jquery
#= require vendor/bootstrap

#= require models/Application

#= require views/QueryView
#= require views/ProfileView
#= require views/ContextView

$ ->
  application = OAQ.app = new OAQ.Application()

  new OAQ.QueryView
    model: application
    el: ($ '#x-query-tree')

  new OAQ.ProfileView
    model: application
    el: ($ '#x-profile-info')

  new OAQ.ContextView
    model: application
    el: ($ '#x-current-context')

  ($ '#x-profile-nav-next').on 'click', ->
    application.moveToNextDossier()

  ($ '#x-profile-nav-prev').on 'click', ->
    application.moveToPrevDossier()

  application.load()
