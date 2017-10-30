import 'shelljs/make'
import test from 'tape'
import dd from 'ddeyes'

import { constants } from '../src'
import { actions } from '../src'

import ReducersSyncTest from './ReducersSyncTest'
import SagasAsyncTest from './SagasAsyncTest'

target.all = ->
  target.sync()
  target.async()

target.constants = -> dd constants
target.actions = ->
  for k, v of actions
    dd k
    dd v 1

target.sync = ->
  test 'Sync Reducers Test'
  , ReducersSyncTest

target.async = ->
  test 'Async Sagas Test'
  , SagasAsyncTest
