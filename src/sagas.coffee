import {
  sagaEffects
  dispatch
} from 'cfx.redux-saga'
import constants from './constants'

# dd = require 'ddeyes'

delay = (ms) ->
  new Promise (resolve) ->
    setTimeout resolve, ms

{
  INCREMENT
  INCREMENT_ASYNC

  DECREMENT
  DECREMENT_ASYNC
} = constants.types

incrementAsync = (action) ->
  # dd { INCREMENT }
  yield sagaEffects.call delay, 1000
  yield dispatch action
  , INCREMENT
  return

decrementAsync = (action) ->
  # dd { DECREMENT }
  yield sagaEffects.call delay, 1000
  yield dispatch action
  , DECREMENT
  return

export default [
  ->
    # dd { INCREMENT_ASYNC }
    yield sagaEffects.takeLatest INCREMENT_ASYNC
    , incrementAsync

  ->
    # dd { DECREMENT_ASYNC }
    yield sagaEffects.takeLatest DECREMENT_ASYNC
    , decrementAsync
]
