var dogescript = require('dogescript');
var fs = require('fs');

// https://developer.mozilla.org/en-US/docs/Web/API/window.btoa
function utf8_to_b64( str ) {
  return window.btoa(unescape(encodeURIComponent( str )));
}
function b64_to_utf8( str ) {
  return decodeURIComponent(escape(window.atob( str )));
}

var input  = document.getElementById('dogescript');
var output = document.getElementById('javascript');

if (location.hash !== '') {
    var hash = location.hash.substring(1);

    var decoded = b64_to_utf8(hash);
    input.value = decoded;
    output.value = dogescript(input.value, true);
} else {
    var content = fs.readFileSync('./demo.djs', 'utf8');
    input.value = content;
    output.value = dogescript(input.value, true);
}

var inputMirror = CodeMirror.fromTextArea(input, {
    lineNumbers: true,
    autofocus: true,
    mode: null
});
var outputMirror = CodeMirror.fromTextArea(output, {
    lineNumbers: true,
    readOnly: true,
    mode: 'javascript'
});

var inputWrapper = inputMirror.display.wrapper;
var outputWrapper = outputMirror.display.wrapper;

inputMirror.on('change', function () {
    var compiled = dogescript(inputMirror.getValue(), true);
    outputMirror.setValue(compiled);
});

// using js to style because why not
inputWrapper.style.cssFloat = 'left';
outputWrapper.style.cssFloat = 'right';

function fixSize() {
    var top = input.getBoundingClientRect().top + document.body.scrollTop;
    var height = (window.innerHeight - top - 170) + 'px';
    inputWrapper.style.height = height;
    outputWrapper.style.height = height; 
}

fixSize();

var debounce = 0;

window.addEventListener('resize', function(e) {
    if (debounce) {
        debounce = clearTimeout(debounce);
    }
    debounce = setTimeout(fixSize, 50);
});

var shareBtn = document.querySelector('.js-share-code');
shareBtn.addEventListener('click', function (e) {
    var encoded = utf8_to_b64(inputMirror.getValue());
    location.hash = encoded;
    shareBtn.innerText = 'Check your location bar!';
    setTimeout(function () {
        shareBtn.innerText = 'Create code URL';
    }, 1500);
    e.preventDefault();
}, false);
