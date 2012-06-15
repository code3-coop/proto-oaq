#= require vendor/jquery
#= require vendor/bootstrap
#= require vendor/underscore
#= require vendor/backbone
#= require vendor/handlebars
#= require vendor/kendo

#= require models/Dossier
#= require views/ProfileView
#= require views/ContextView

$ ->
  ($ '#req-tree').kendoTreeView()

  dossier = new OAQ.Dossier _id:123

  new OAQ.ProfileView
    model: dossier
    el: ($ '#x-profile-info-prev')
  new OAQ.ProfileView
    model: dossier
    el: ($ '#x-profile-info-curr')
  new OAQ.ProfileView
    model: dossier
    el: ($ '#x-profile-info-next')

  ($ '#x-profile-nav-prev').on 'click', (e) ->
    e.preventDefault()
    wrapper = ($ '#x-profile-info-wrapper')
    wrapper.css('left', "+=#{wrapper.width()}px")

  ($ '#x-profile-nav-next').on 'click', (e) ->
    e.preventDefault()
    wrapper = ($ '#x-profile-info-wrapper')
    wrapper.css('left', "-=#{wrapper.width()}px")

  new OAQ.ContextView
    model: dossier
    el: ($ '#x-current-context')

  dossier.fetch()
