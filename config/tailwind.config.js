const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
    "./app/components/**/*.{erb,html}",
  ],
  theme: {
    extend: {
      colors: {
        primary: "#87619A",
        primaryFaded: "#E7DFEA",
        primaryText: "#51596A",
      },
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
        logoTitle: ["MedievalSharp", "cursive"],
        headings: ["Dosis", "sans-serif"],
      },
      backgroundImage: {
        "tavern-landing": "url('tavern-landing-bg.jpg')",
        
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};
