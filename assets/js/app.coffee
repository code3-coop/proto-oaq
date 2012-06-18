#= require vendor/jquery
#= require vendor/bootstrap
#= require vendor/kendo
#= require models/Application
#= require views/ProfileView
#= require views/ContextView

$ ->
  ($ '#req-tree').kendoTreeView()

  application = new OAQ.Application()

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
