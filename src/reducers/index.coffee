import { reduxActions } from 'cfx.redux-actions'
{ handleActions } = reduxActions
import { mergeReduce } from 'cfx.redux'

dd = require 'ddeyes'

initialState =
  count: 0

count = handleActions

  INCREMENT: (state, action) ->
    action.payload or= 1
    state + action.payload

  DECREMENT: (state, action) ->
    action.payload or= 1
    state - action.payload

, 0

export default mergeReduce {
  count
}
, initialState
