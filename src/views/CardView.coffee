class window.CardView extends Backbone.View
  className: 'card'

  tagName: 'span'

  # template: _.template "<span></span>"

  initialize: ->
    @render()
    @model.on 'change:revealed', ->
      @$el.find('span.covered').css('background-image', 'url("' + @model.get 'url' + '")') 
      @render()
    , @

  render: ->
    @$el.children().detach()
    # @$el.html @template @model.attributes
    url = @model.get 'url'
    if @model.get 'revealed' then @$el.css('background-image', 'url(' + url + ')')
    @$el.addClass 'covered' unless @model.get 'revealed'
    # @$el.find('.covered').toggleakljf