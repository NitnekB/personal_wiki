# React: Component

React applications are made out of components.

A component is a small, reusable chunk of code that is responsible for one job,
such as render some HTML.

~~~js
import React, { Component } from 'react';
import ReactDOM from 'react-dom';

class Example extends Component {
  render() {
    return <h1>Hello world</h1>;
  }
};

ReactDOM.render(
  <Example />,
  document.getElementById('app')
);
~~~

This `Example` component return a JSX title "Hello world".
At the end, we use the ReactDOM library to render our component.

## Things to know about

Every component must come from a component class.

A component class is like a factory that creates components.
You use it to produce as many components as you want.
`React.Component` is in fact a [JavaScript class](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes).

Two ways to declare a component:

~~~js
import React from 'react';

class Example extends React.Component {
  render() {}
}

// OR

import React, { Component } from 'react';

class Example extends Component {
  render() {}
}
~~~

**Component class variable names must begin with capital letters!**

### Variable Attribute in a Component

Here a JavaScript objet named picture:

~~~js
const picture = {
  src:  'https://images.unsplash.com/photo-1486915585284-e6cb5cd1ec87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3150&q=80',
  alt: 'Public gare',
  width:  '200px'
};
~~~

Our picture object can be passed to a component like this:

~~~js
// Here the picture const

class Picture extends React.Component {
  render() {
    return (
      <div>
        <h1>Public Gare</h1>
        <img
          src={picture.src}
          alt={picture.alt}
          width={picture.width} />
      </div>
    );
  }
}
~~~

**Return**!

A `render()` function **must have** a **return** statement.

### Conditional in a Render Function

The if statement is located inside of the render function, but before the return statement.

~~~js
import React, { Component } from 'react';
import ReactDOM from 'react-dom';

class DoThing extends Component {
  render() {
    let task;
    if (!somethingHappens) {
      task = 'go deep into the wood!';
    } else {
      task = 'stay at home';
    }

    return (
      <div>
        <h1>Today I am going to {task}!</h1>
      </div>
    );
  }
}

ReactDOM.render(
	<DoThing />,
	document.getElementById('app')
);
~~~

### `this` in a Component

Since a Component is a JavaScript Object, the word `this` is frequently used

~~~js
class Example extends React.Component {
  get place() {
    return 'Paris';
  }

  render() {
    return <h1>I want to go in {this.place}!</h1>;
  }
}
~~~

`this` refers to an instance of Example object, on which this‘s enclosing method, in this case `.render()`, is called.
Caution: technically `this` can refers to something else, but it's almost unlikely.

`this.place` doesn't require to add parenthesis because `.place` is a getter method: `get place() {}`.

Here's a better explanation about [`this` in JavaScript](https://dmitripavlutin.com/gentle-explanation-of-this-in-javascript/)

### Event Listener in a Component

An event handler is a function that gets called in response to an event.
In the above example, the event handler is `handleAlert()`.

In React, you define event handlers as methods on a component class. Like this:

~~~js
class Example extends React.Component {
  handleAlert() {
    alert('I am an alert message');
  }

  render() {
    return (
      <div onHover={this.handleAlert}>
      </div>
    );
  }
}
~~~

`.handleAlert()` is being used as an event handler.
It will be called any time that a user hovers over the rendered <div></div>.

## Patterns

Like for any programming langages and frameworks, React allows developers to use
pattern in order to enhance the way they work.
Here's some common patterns that are commonly used with React.

### Stateless Components Inherit From Stateful Components

Programming pattern uses two React components:

* a stateful component: _Stateful_ describes any component that has a state property
* a stateless component: _Stateless_ describes any component that does not

Let's demonstrate how it works with two classes `Parent` and `Child`.

~~~js
// Parent.js
import React, { Component } from 'react';
import ReactDOM from 'react-dom';
// Import Child component with dynamic path
import { Child } from './Child';

class Parent extends Component {
  constructor(props) {
    super(props);
    this.state = {
      name: 'Quentin'
    }
  }

  render() {
    return <Child name={this.state.name} />;
  }
}

ReactDOM.render(<Parent />, document.getElementById('app'));


// Child.js
import React, { Component } from 'react';

// Use export keyword to allows Parent class to render the Child
export class Child extends Component {
  render() {
    // Display props.name from Parent class
    return <h1>Hey, my name is {this.props.name}!</h1>;
  }
}
~~~

NB: Any component rendered by a different component must be included in an export statement.

#### Don't Update props

A component can change its state by calling `this.setState()`.
But what abut _props_? Can we update them?

The answer is obviously not.
A component should never update `this.props`.

If a component can’t change its props, then what are props for?
A React component should use props to store information that can be changed, but only by a different component.

A React component should use state to store information that the component itself can change.

This is the main difference between a `props` and a `state`.

### Event handler

To make a child component update its parent’s state, we must define a state-changing method on the parent.

On the above example, we defined a class method `changeAttr()` that takes a new attribute value and update the state of this attribute.

~~~js
changeAttr(newAttrValue) {
  this.setState({
    attr: newAttrValue
  });
}
~~~

We now need to make sure that the `changeAttr()` method will always refer to the instance of Parent class, even when we pass it down to the Child component.

In the constructor method of Parent, bind `this.changeAttr` to the current value of this and store it in `this.changeAttr`.

Now we need to pass our new update event function into Child object in `render()`method.

If we take back our previous example, here's how it would be elvolved:

~~~js
// Parent.js
import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import { Child } from './Child';

class Parent extends Component {
  constructor(props) {
    super(props);
    // We have to bind this on our method
    // Remember we can prevent this behaviour using ES5+ with arrow function
		this.changeName = this.changeName.bind(this);
    this.state = { name: 'Quentin' };
  }
  
  // New event handler method to update the state of name attribute
  changeName(name) {
    this.setState({
      name: name
    });
  }

  render() {
    // Add onChange attribute with method call on value
    return <Child name={this.state.name} onChange={this.changeName} />
  }
}

// Render JSX using ReactDOM
ReactDOM.render(
	<Parent />,
	document.getElementById('app')
);
~~~

Now we also need to update the Child class to manage updated attribute

~~~js
// Child.js
import React, { Component } from 'react';

export class Child extends Component {
  constructor(props) {
    super(props);
    // We have to bind this on our method
    this.handleChange = this.handleChange.bind(this);
  }

  // Define handleChange method that takes an event
  // and call onChange with new attribute from user to apply new change
  handleChange(evt) {
    const name = evt.target.value;
    this.props.onChange(name);
  }

  render() {
    return (
      <div>
        <h1>
          Hello, I'm {this.props.name}!
        </h1>
        <!--
          Use select to choose a name
          Define onChange attribute and use handleChange method as value
        -->
        <select id="names" onChange={this.handleChange}>
          <option value="Quentin">
            Quentin
          </option>
          <option value="Romain">
            Romain
          </option>
        </select>
      </div>
    );
  }
}
~~~

Event handler are very usefull to apply changes on several part of an application.
As we understand, we should never update a prop.
React _state_ concept allows developers to manage data update everywhere without any trouble.

### Separate display from update with multiple children components

The idea is to separate updating component from the displayed one.
To make that happened, we'll create a new component `DisplayChild`.

~~~js
// DisplayChild.js
import React, { Component } from 'react';

export class DisplayChild extends Component {
  render() {
    const name = this.props.name;
    return (
      <div>
        <h1>Hey, I'm {name}!</h1>
        <h2>Don't you think {name} is a great name?</h2>
      </div>
    );
  }
}
~~~

Then we must applied some change on parent class

~~~js
// Parent.js
import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import { Child } from './Child';
import { DisplayChild } from './DisplayChild';

class Parent extends Component {
  constructor(props) {
    super(props);
    this.changeName = this.changeName.bind(this);
    this.state = { name: 'Quentin' };
  }

  changeName(name) {
    this.setState({
      name: name
    });
  }

  render() {
    return (
      <div>
        <!-- Child component allows to update content -->
        <Child onChange={this.changeName} />
        <!-- DisplayChild component allows to display current state data name -->
        <DisplayChild name={this.state.name} />
      </div>
    );
  }
});

ReactDOM.render(
  <Parent />,
  document.getElementById('app')
);
~~~

Here's the most common React pattern.
