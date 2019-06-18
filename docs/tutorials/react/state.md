# React: State

State are in the heart of React Component,
we need to understand well this concept in order to work with React apps.

## Setting Initial State

A React component can access dynamic information in two ways: _props_ and _state_.

Unlike props, a component’s state is not passed in from the outside.
A component decides its own state.

To make a component have state, give the component a state property.
This property should be declared inside of a constructor method, like this:

~~~js
import React, { Component } from 'react';

class Example extends Component {
  constructor(props) {
    super(props);
    this.state = { text: 'Hello world' };
  }

  render() {
    return <div></div>;
  }
}

<Example />
~~~

`this.state` should be equal to an object, like in the example above.
This object represents the initial “state” of any component instance.

`constructor` and `super` are both features of ES6, not unique to React.
There is nothing particularly React-y about their usage here.

A full explanation of their functionality [can be found here](https://hacks.mozilla.org/2015/07/es6-in-depth-classes/).
It is important to note that React components always have to call super in their constructors to be set up properly.

`<Example />` has a state, and its state is equal to `{ mood: 'decent' }`.

NB: Methods should never be comma-separated, if inside of a class body.
This is to emphasize the fact that classes and object literals are different.

## Access a Component's state

To read a component’s state, use the expression `this.state.property-name`:

~~~js
import React, { Component } from 'react';

class HelloWorld extends Component {
  constructor(props) {
    super(props);
    this.state = { text: 'Hello world' };
  }

  render() {
    return (
      <h1>
        {this.state.text}!
      </h1>
    );
  }
}
~~~

The above component class reads a property in its state from inside of its render function.

Just like `this.props`, you can use `this.state` from any property defined inside of a component class’s body.

## Update state with `this.setState`

A component can do more than just read its own state.
It can also change its own state.

A component changes its state by calling the function `this.setState()`.

It takes two arguments:

* an object that will update the component’s state,
* and a callback (you basically never need the callback).

`this.setState()` takes an object, and merges that object with the component’s current state.
If there are properties in the current state that aren’t part of that object, then those properties remain how they were.

Example:

~~~js
import React, { Component } from 'react';

class IsReactGood extends Component {
  constructor(props) {
    super(props);
    this.state = { react: 'good' };
    // Rebind this to the toggleChoice method
    // Can be replaced by new ES6+ function syntax () = () => {};
    this.toggleChoice = this.toggleChoice.bind(this);
  }

  toggleChoice() {
    const newChoice = this.state.react === 'good' ? 'bad' : 'good';
    this.setState({ react: newChoice });
  }

  render() {
    return (
      <div>
        <h1>I'm think React is {this.state.react}!</h1>
        <button onClick={this.toggleChoice}>
          Click Me
        </button>
      </div>
    );
  }
}
~~~

## Call `this.setState` from Another Function

The most common way to call `this.setState()` is to call a custom function that wraps a `this.setState()` call.

~~~js
import React, { Component } from 'react';
import ReactDOM from 'react-dom';

class Example extends React.Component {
  constructor(props) {
    super(props);
    this.state = { glass: 'empty' };
    this.fillGlass = this.fillGlass.bind(this);
  }

  fillGlass() {
    this.setState({
      glass: 'full'
    });
  }

  render() {
    return (
      <div>
        <h1>My glass is {this.state.glass}!</h1>
        <button onClick={this.fillGlass}>
          Fill my glass!
        </button>
      </div>
    );
  }
}

ReactDOM.render(<Example />, document.getElementById('app'));
~~~

Notice how the method `fillGlass()` contains a call to `this.setState()`.

Let’s walk through how a function wrapping `this.setState()` might work in practice.

Here is how a `<Example />`‘s state would be set:

A user triggers an event (in this case a click event, triggered by clicking on a `<button>Fill my glass!</button>`).

When this listened-for event occurs, it calls an event handler function (in this case, `this.fillGlass()`.

Inside of the body of the event handler, `this.setState()` is called.
The component’s state is now changed!
This is possible thanks to `this.fillGlass = this.fillGlass.bind(this);`.

For an in-depth explanation of this kind of binding trickery, begin with the [React docs](https://reactjs.org/docs/handling-events.html).
For the less curious, just know that in React, whenever you define an event handler that uses this, you need to add this.methodName = this.methodName.bind(this) to your constructor function.

But there's an alternative using JS ES6+ function syntax.
Indeed you can replace function signature by the new one:

~~~js
fillGlass = () => {
  this.setState({
    glass: 'full'
  });
}
~~~

Clicking on the button `Fill my glass!` will update the state `glass` from _empty_ to _full_.

One final note:

* you can’t call `this.setState()` from inside of the render function.
* Any time that you call `this.setState()`, it AUTOMATICALLY calls `.render()` as soon as the state has changed.
