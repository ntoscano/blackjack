class window.CardView extends Backbone.View
  className: 'card'

  tagName: 'span'

  template: _.template "<img src=\"<%= url %>\">"

  initialize: ->
    @render()
    @model.on 'change:revealed', ->
      @$el.find('img.covered').attr('src', @model.get 'url') 
      @render()
    , @

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.children().addClass 'covered' unless @model.get 'revealed'
    @$el.find('img.covered').attr('src', 'img/card-back.png') 