# React: JSX

JSX is not coming from React.
Concretely, it is a syntax extension for JavaScript and looks like this following example:

~~~js
const h1 = <h1>Hello, world!</h1>;
~~~

## Specifications

It also means that JSX is not valid JavaScript.
Web browsers can’t read it!

If a JavaScript file contains JSX code, then that file will have to be compiled.
That means that before the file reaches a web browser, a JSX compiler will translate any JSX into regular JavaScript.

JSX elements are treated as JavaScript expressions.
They can go anywhere that JavaScript expressions can go.

It means that a JSX element can be saved in a variable, passed to a function, stored in an object or something else:

~~~js
const myObject = {
  h1: <h1>Hello, world!</h1>,
  h2: <h2>My favorite hello world page</h2>,
  h3: <h3 id="big">It is a good day to learn about JS!</h3>
}
~~~

The same rules as for HTML applies for JSX.
So, you can use HTML attributes as you can see on the `h3` previous example.

But there are some exception!

### class vs className

Grammar in JSX is mostly the same as in HTML, but there are subtle differences to watch out for.
Probably the most frequent of these involves the word `class`.

Indeed we'll need a specific keyword to use `class` in React

~~~js
// HTML
<h1 class="big">Hello world</h1>

// The same JSX with React.js
<h1 className="big">Hello world</h1>
~~~

The reason is because JSX gets translated into JavaScript, and `class` is a reserved word in JavaScript.

### Self-closing tags

In JSX, you have to include the slash on element.
If you write a self-closing tag in JSX and forget the slash, you will raise an error.

~~~js
// Ok in JSX
<br />

// NOT OK AT ALL in JSX
<br>
~~~

### Nested JSX

Nested JSX requires to use parentheses and can be saved as variables:

~~~js
const helloWorldDivExample = (
	<div>
    <h1>Hello world</h1>
  </div>
)
~~~

### Use `.map` in JSX

The array method `.map()` comes up often in React.
It’s good to get in the habit of using it alongside JSX.

~~~js
const names = ['Jon', 'Aria', 'Daeneris'];

const listNames = names.map(name => <li>{name}</li>);

<ul>{listNames}</ul>
~~~

In the above example, we start out with an array of `names`.
We call `.map()` on this array of `names`, and the `.map()` call returns a new array of `<li>`.

### Use JSX `key` attribute

When you make a list in JSX, sometimes your list will need to use ids which is called `keys`:

~~~js
<ul>
  <li key="ex-01">Jon</li>
  <li key="ex-02">Daeneris</li>
</ul>
~~~

`keys` are hidden on the DOM!
React uses them internally to keep track of lists.

Not all lists need to have keys.
A list needs keys if either of the following are true:

* The list-items have memory from one render to the next,
* A list’s order might be shuffled.

No need you use them if it's not answers to any previous conditions.

## JSX constraints

**A JSX expression must have exactly one outermost element.**

This is not a valid JSX:

~~~js
const wrongExample = (
  <p>Hello</p>
  <p>World</p>
)
~~~

But this is valid:

~~~js
const goodExample = (
  <div>
    <p>Hello</p>
    <p>World</p>
  </div>
)
~~~

Also, React allows to use a common pattern which called [_Fragment_](https://reactjs.org/docs/fragments.html)

~~~js
render() {
  return (
    <React.Fragment>
      <p>Hello</p>
      <p>World</p>
    </React.Fragment>
  );
}
~~~

## React JSX rendering

Standard way to render element with React is the _ReactDOM_ library

~~~js
import React from 'react';
import ReactDOM from 'react-dom';

ReactDOM.render(
  <h1>Hello world</h1>,
  document.getElementById('app')
);
~~~

_React_ and _ReactDOM_ both are specific React standard JavaScript libraries.

To render JavaScript on JSX, you have to use braces `{}`

~~~js
ReactDOM.render(
  <h1> {2 + 3} </h1>,
  document.getElementById('app')
);
// => <h1> 5 </h1>
~~~

Same goes for variables

~~~js
const text = 'world';

const jsxExpression = <p>Hello {text}!</p>
~~~

And for everything else such as function

~~~js
function helloWorld() {
  alert('Hello world!');
}

<img onClick={helloWorld} />
~~~

### JSX conditional `&&`

Like the ternary operator, `&&` is not React-specific, but it is often used in React.
`&&` works best in conditionals that will sometimes do an action, but other times do nothing at all.

You can know more about [conditional rendering on this article](https://blog.logrocket.com/conditional-rendering-in-react-c6b0e5af381e/).

### How JSX rendering works: `React.createElement`

You must understand that you can write React code without using JSX at all!

The following JSX expression:

~~~js
const h1 = <h1>Hello world</h1>;
~~~~

can be rewritten without JSX, like this:

~~~js
const h1 = React.createElement(
  "h1",
  null,
  "Hello, world"
);
~~~

As a matter of fact, the compiler transforms the JSX element into `React.createElement()` for every JSX element.

---

To learn more about JSX, fell free to read the [official Introduction](https://reactjs.org/docs/introducing-jsx.html).
