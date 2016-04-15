{ reduxActions } = require 'cfx.redux-actions'
{ handleActions } = reduxActions
{ mergeReduce } = require 'cfx.redux'
constants = require '../constants/index'

{
  INCREMENT
  DECREMENT
} = constants.types

initialState =
  count: 0

count = handleActions

  INCREMENT: (state, action) ->
    action.payload or= 1
    state + action.payload

  DECREMENT: (state, action) ->
    action.payload or= 1
    state - action.payload

# , 0

module.exports = mergeReduce {
  count
}
, initialState
