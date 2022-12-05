/** @type {import('tailwindcss').Config} */
const colors = require('tailwindcss/colors')
const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  mode: 'jit',
  content: [
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/views/**/*.{html,html.erb,erb}',
    './app/javascript/components/**/*.js',
  ],
  theme: {
    fontFamily: {
      'sans': ["BlinkMacSystemFont", "Avenir Next", "Avenir",
        "Nimbus Sans L", "Roboto", "Noto Sans", "Segoe UI", "Arial", "Helvetica",
        "Helvetica Neue", "sans-serif"],
      'mono': ["Consolas", "Menlo", "Monaco", "Andale Mono", "Ubuntu Mono", "monospace"]
    },
    colors: {
      /* Common colors */
      white: '#FFFFFF',
      black: '#000000',
      green: '#219653',
      red: '#EB5757',
      blue: '#0066C0',
      'dark-blue': '#232F3E',
      yellow: '#F9B211',
      orange: '#FF9900',
      gray: '#BDBDBD',
      bluegray: '#28384d',
      lightgray: '#FAFAFA25',

      /* Spec colors */
      background: '#F6F6F6',
      navbar: '#11233B',
      sidebar: '#2B3D55',
      'login-background': '#232F3E',
      'login-menu': '#1E2C3D',
      'login-border': '#FAFAFA',
    },
    extend: {
    },
  },
  corePlugins: {
    aspectRatio: false,
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/line-clamp'),
  ],
}
