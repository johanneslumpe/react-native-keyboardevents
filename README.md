## react-native-keyboardevents

Keyboard events for react-native


## Usage

First you need to install react-native-keyboardevents:

```javascript
npm install react-native-keyboardevents --save
```

In XCode, in the project navigator, right click Libraries ➜ Add Files to [your project's name] Go to node_modules ➜ react-native-keyboardevents and add the .xcodeproj file

In XCode, in the project navigator, select your project. Add the lib*.a from the keyboardevents project to your project's Build Phases ➜ Link Binary With Libraries Click .xcodeproj file you added before in the project navigator and go the Build Settings tab. Make sure 'All' is toggled on (instead of 'Basic'). Look for Header Search Paths and make sure it contains both $(SRCROOT)/../react-native/React and $(SRCROOT)/../../React - mark both as recursive.

Run your project (Cmd+R)

(Thanks to @brysgo for writing the instructions)

## Examples

### Basic

```javascript
// require the module
var KeyboardEvents = require('react-native-keyboardevents');

// Now get a handle on the event emitter and add your callbacks
// to the desired events.
var KeyboardEventEmitter = KeyboardEvents.Emitter;

// Each event will receive a `frames` object, which contains three keys -
// `begin`,  `end`, and `duration` . The `begin` and `end`  keys each
// contain an object describing the bounds of the keyboard (x, y, width
// and height). The `duration` key contains the length of the keyboard
// animation in seconds.

// The frame in `begin` describes the bounds of the keyboard before the
// animation occurred and the frame in `end` describes the bounds the keyboard
// will have, after the animation has completed.
KeyboardEventEmitter.on(KeyboardEvents.KeyboardWillShowEvent, (frames) => {
  console.log('will show', frames);
});

KeyboardEventEmitter.on(KeyboardEvents.KeyboardDidShowEvent, (frames) => {
  console.log('did show', frames);
});

KeyboardEventEmitter.on(KeyboardEvents.KeyboardWillHideEvent, (frames) => {
  console.log('will hide', frames);
});

KeyboardEventEmitter.on(KeyboardEvents.KeyboardDidHideEvent, (frames) => {
  console.log('did hide', frames);
});

KeyboardEventEmitter.on(KeyboardEvents.KeyboardWillChangeFrameEvent, (frames) => {
  console.log('will change', frames);
});

KeyboardEventEmitter.on(KeyboardEvents.KeyboardDidChangeFrameEvent, (frames) => {
  console.log('did change', frames);
});
```

### How to move a view when the keyboard shows up
Distilled from @brysgo's answer on stackoverflow:
[how-to-auto-slide-the-window-out-from-behind-keyboard-when-textinput-has-focus](http://stackoverflow.com/questions/29313244/how-to-auto-slide-the-window-out-from-behind-keyboard-when-textinput-has-focus)

```javascript
var React = require('react-native');
var KeyboardEvents = require('react-native-keyboardevents');
var KeyboardEventEmitter = KeyboardEvents.Emitter;

class YourComponent extends React.Component {

  constructor(props, context) {
    super(props, context);

    this.state = {
      keyboardSpace: 0
    };

    this.updateKeyboardSpace = this.updateKeyboardSpace.bind(this);
    this.resetKeyboardSpace = this.resetKeyboardSpace.bind(this);
  }

  updateKeyboardSpace(frames) {
    this.setState({keyboardSpace: frames.end.height});
  }

  resetKeyboardSpace() {
    this.setState({keyboardSpace: 0});
  }

  componentDidMount() {
    KeyboardEventEmitter.on(KeyboardEvents.KeyboardDidShowEvent, this.updateKeyboardSpace);
    KeyboardEventEmitter.on(KeyboardEvents.KeyboardWillHideEvent, this.resetKeyboardSpace);
  }

  componentWillUnmount() {
    KeyboardEventEmitter.off(KeyboardEvents.KeyboardDidShowEvent, this.updateKeyboardSpace);
    KeyboardEventEmitter.off(KeyboardEvents.KeyboardWillHideEvent, this.resetKeyboardSpace);
  }

  render() {
    // create your content here
    return (
      <View>
      // add your content here

      // when the keyboard is shown, this spacer will push up all your other content
      <View style={{height: this.state.keyboardSpace}}></View>
      </View>
    );
  }
}

```
