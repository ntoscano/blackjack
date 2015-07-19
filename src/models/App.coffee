# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'game', new Game()
    @set 'money', 200

    @get('game').on 'playerWin', ->
      @set('money', @get('money') + 10)
    , @

    @get('game').on 'tie', ->
      @set('money', @get('money') + 5)
    , @

    @get('game').on 'newGame', ->
      @set('money', @get('money') - 5)
    , @