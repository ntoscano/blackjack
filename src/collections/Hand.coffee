class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    last = @deck.pop()
    @add(last)
    if Math.min.apply(null, @scores()) > 21
      setTimeout(@trigger.bind(@, 'bust'), 500)
    last

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  stand: ->
    @trigger 'stand'

  dealerHit: (playerHand)->
    dealerScore = @highestLegalScore()
    playerScore = playerHand.highestLegalScore()
    dealerWinning = playerScore < dealerScore
    if @scores[0] == 7 and @scores[1] == 17
      @hit()
      if highestLegalScore() <= 21 then @dealerHit(playerHand)
    else if dealerScore >= 17
      if dealerWinning then return @trigger 'dealerWin'
      else if dealerScore == playerScore then return @trigger 'tie'
      else if not dealerWinning then return @trigger 'bust'
    else if dealerScore < 17
      @hit()
      if @highestLegalScore() <= 21 then @dealerHit(playerHand)


  highestLegalScore: ->
    if @scores()[1] <= 21 then @scores()[1] else @scores()[0]
