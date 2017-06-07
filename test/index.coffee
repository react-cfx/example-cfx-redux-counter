#!/usr/bin/env coffee
test = require 'tape'
require 'shelljs/make'
dd = require 'ddeyes'

ReducersSyncTest = require './ReducersSyncTest'
SagasAsyncTest = require './SagasAsyncTest'

constants = (
  require '../dest/constants/index'
).default
actions = (
  require '../dest/actions/index'
).default

target.all = ->
  # target.sync()
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
