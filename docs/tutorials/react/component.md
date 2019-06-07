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


