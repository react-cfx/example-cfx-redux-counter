import * as sagaEffects from 'redux-saga/effects'
import { default as constants } from '../constants/index'

# dd = require 'ddeyes'

dispatch = (action, actionType) ->
  sagaEffects.put Object.assign {}
  , action
  , type: actionType

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

rootSaga = [
  ->
    # dd { INCREMENT_ASYNC }
    yield sagaEffects.takeLatest INCREMENT_ASYNC
    , incrementAsync

  ->
    # dd { DECREMENT_ASYNC }
    yield sagaEffects.takeLatest DECREMENT_ASYNC
    , decrementAsync
]

export default rootSaga
