require("quicker").setup({
  keys = {
    {
      ">",
      function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end,
      desc = "Quicker: expand context",
    },
    {
      "<",
      function() require("quicker").collapse() end,
      desc = "Quicker: collapse context",
    },
  },
})
