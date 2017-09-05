const hyperstream = require('hyperstream');
const html = require('simple-html-index');
const fs = require('fs');
const glob = require('glob');
// const path = require('path');
const combinedStream = require('combined-stream').create();
const htmls = html({ entry: 'bundle.js', css: 'main.css' });

glob('src/slides/*.html', (err, files) => {
  if (err) throw err;

  files.forEach((file, i) => {
    combinedStream.append(fs.createReadStream(file));
  });

  const body = hyperstream({
    body: {
      _prependHtml: '<div id="main"></div>'
    }
  });

  const slides = hyperstream({
    '#main': {
      _appendHtml: combinedStream
    }
  });

  htmls.pipe(body).pipe(slides).pipe(process.stdout);
});
