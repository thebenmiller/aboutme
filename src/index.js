const bespoke = require('bespoke');
const bespokeNebula = require('bespoke-theme-nebula');
const besokeKeys = require('bespoke-keys');
const bespokeHash = require('bespoke-hash');
const bespokeBackdrop = require('bespoke-backdrop');
const bespokeScale = require('bespoke-scale');

const deck = bespoke.from('#main', [
  bespokeNebula(),
  besokeKeys(),
  bespokeHash(),
  bespokeBackdrop(),
  bespokeScale()
]);

deck.on('activate', event => {
  const videos = event.slide.querySelectorAll('video');
  if(videos.length){
    console.log(videos[0])
    videos[0].play();
  }
});
