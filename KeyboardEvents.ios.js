'use strict';

var RCTDeviceEventEmitter = require('RCTDeviceEventEmitter');
var RNKeyboardEventsManager = require('NativeModules').RNKeyboardEventsManager;
var EventEmitter = require('eventemitter3').EventEmitter;

var KeyboardEventEmitter = new EventEmitter();

RCTDeviceEventEmitter.addListener(
  RNKeyboardEventsManager.KeyboardWillShow,
  () => {
    KeyboardEventEmitter.emit(RNKeyboardEventsManager.KeyboardWillShow);
  }
);

RCTDeviceEventEmitter.addListener(
  RNKeyboardEventsManager.KeyboardDidShow,
  (size) => {
    KeyboardEventEmitter.emit(RNKeyboardEventsManager.KeyboardDidShow, size);
  }
);

RCTDeviceEventEmitter.addListener(
  RNKeyboardEventsManager.KeyboardWillHide,
  () => {
    KeyboardEventEmitter.emit(RNKeyboardEventsManager.KeyboardWillHide);
  }
);

RCTDeviceEventEmitter.addListener(
  RNKeyboardEventsManager.KeyboardDidHide,
  () => {
    KeyboardEventEmitter.emit(RNKeyboardEventsManager.KeyboardDidHide);
  }
);

module.exports = {
  Emitter: KeyboardEventEmitter,
  KeyboardWillShowEvent: RNKeyboardEventsManager.KeyboardWillShow,
  KeyboardDidShowEvent: RNKeyboardEventsManager.KeyboardDidShow,
  KeyboardWillHideEvent: RNKeyboardEventsManager.KeyboardWillHide,
  KeyboardDidHideEvent: RNKeyboardEventsManager.KeyboardDidHide
};
