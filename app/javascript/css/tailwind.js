// TODO: change these colors!
const primary = "hsl(20deg 75% 58%)"; // orange
const secondary = "hsl(200deg 75% 58%)"; // blue

module.exports = {
  purge: [
    "./app/**/.html.erb",
    "./app/components/**/*.rb",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/javascript/**/*.vue",
    "./app/javascript/**/*.jsx",
  ],
  theme: {
    extend: {},
    backgroundColor: theme => ({
      ...theme("colors"),
      primary,
      secondary,
      // danger: "#e3342f",
    }),
    borderColor: theme => ({
      ...theme("colors"),
      // default: theme("colors.gray.300", "currentColor"),
      primary,
      secondary,
      // danger: "#e3342f",
    }),
    textColor: theme => ({
      ...theme("colors"),
      primary,
      secondary,
      // danger: "#e3342f",
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
