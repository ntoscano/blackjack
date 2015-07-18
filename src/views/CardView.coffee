class window.CardView extends Backbone.View
  className: 'card'

  template: _.template "<img src=\"<%= url %>\">"

  initialize: ->
    @render()
    @model.on 'flip', ->
      @$el.find('img.covered').attr('src', @model.get 'url') 
      @render()
    , @

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    # console.log @$el
    @$el.children().addClass 'covered' unless @model.get 'revealed'
    @$el.find('img.covered').attr('src', 'img/card-back.png') 