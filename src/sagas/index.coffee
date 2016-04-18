{ assign } = Object
{
  saga
  sagaEffects
  dispatch
} = require 'cfx.redux-saga'
{ takeEvery } = saga
{
  put
  call
} = sagaEffects
constants = require '../constants/index'
{
  INCREMENT
  INCREMENT_ASYNC

  DECREMENT
  DECREMENT_ASYNC
} = constants.types

delay = (ms) ->
  new Promise (resolve) ->
    setTimeout resolve, ms

incrementAsync = (action) ->
  yield call delay, 1000
  yield dispatch action
  , INCREMENT
  return

decrementAsync = (action) ->
  yield call delay, 1000
  yield dispatch action
  , DECREMENT
  return

rootSaga = [
  ->
    yield from takeEvery INCREMENT_ASYNC
    , incrementAsync

  ->
    yield from takeEvery DECREMENT_ASYNC
    , decrementAsync
]

module.exports = rootSaga