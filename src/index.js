const bespoke = require('bespoke');
const bespokeNebula = require('bespoke-theme-nebula');
const besokeKeys = require('bespoke-keys');
const bespokeHash = require('bespoke-hash');
const bespokeBackdrop = require('bespoke-backdrop');
const bespokeScale = require('bespoke-scale');

bespoke.from('#main', [
  bespokeNebula(),
  besokeKeys(),
  bespokeHash(),
  bespokeBackdrop(),
  bespokeScale()
]);
