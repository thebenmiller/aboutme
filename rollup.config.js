import resolve from 'rollup-plugin-node-resolve';
import commonjs from 'rollup-plugin-commonjs';
import babel from 'rollup-plugin-babel';
import uglify from 'rollup-plugin-uglify';

export default {
  input: 'src/index.js',
  plugins: [
    resolve({
      browser: true,
      customResolveOptions: {
        moduleDirectory: 'node_modules'
      }
    }),
    commonjs(),
    babel({
      exclude: 'node_modules/**'
    })
    // uglify()
  ],
  output: {
    file: 'build/bundle.js',
    format: 'umd',
    name: 'preso'
  }
};
