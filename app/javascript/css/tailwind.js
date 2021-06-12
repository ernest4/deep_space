// TODO: change these colors!
const primary = "hsl(20deg 75% 58%)"; // orange
const secondary = "hsl(200deg 75% 58%)"; // blue
const tertiary = "hsl(43deg 97% 56%)"; // yellow
const danger = "hsl(2deg 76% 54%)"; // red

module.exports = {
  purge: {
    content: [
      "./app/**/.html.erb",
      "./app/components/**/*.rb",
      "./app/helpers/**/*.rb",
      "./app/javascript/**/*.js",
      "./app/javascript/**/*.vue",
      "./app/javascript/**/*.jsx",
    ],
    // These options are passed through directly to PurgeCSS
    options: {
      safelist: ["g-bg-deep-space-blue", "w-56"],
      // blocklist: [/^debug-/],
      // keyframes: true,
      // fontFace: true,
    },
  },
  theme: {
    extend: {},
    backgroundColor: theme => ({
      ...theme("colors"),
      primary,
      secondary,
      tertiary,
      danger,
    }),
    borderColor: theme => ({
      ...theme("colors"),
      // default: theme("colors.gray.300", "currentColor"),
      primary,
      secondary,
      tertiary,
      danger,
    }),
    textColor: theme => ({
      ...theme("colors"),
      primary,
      secondary,
      tertiary,
      danger,
    }),
  },
  variants: {
    textColor: ["responsive", "hover", "focus", "group-hover"],
  },
  plugins: [],
  future: {
    removeDeprecatedGapUtilities: true,
    purgeLayersByDefault: true,
  },
};
