#= require jquery
#= require bootstrap
#= require kendo
#= require underscore
#= require backbone

#= require_tree models

$ ->
  ($ '#req-tree').kendoTreeView()

  currentFile = new OAQ.Dossier({_id:123}).fetch()
