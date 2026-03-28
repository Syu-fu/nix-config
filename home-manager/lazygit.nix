{
  programs.lazygit = {
    enable = true;
    settings = {
      notARepository = "quit";
      git = {
        autoFetch = false;
        disableForcePushing = true;
        parseEmoji = true;
        paging = {
          colorArg = "always";
          pager = "delta --paging=never";
          externalDiffCommand = "difft --color=always --display=inline --syntax-highlight=on";
        };
        log = {
          showGraph = "always";
        };
      };
      gui = {
        language = "en";
        timeFormat = "2006-01-02 15:04";
        showRandomTip = false;
        showBottomLine = false;
        showIcons = true;
      };
      os = {
        editPreset = "nvim";
        edit = "nvr -l --remote {{filename}}";
        editAtLine = "nvr -l --remote {{filename}} -c G{{line}}";
      };
      promptToReturnFromSubprocess = false;
    };
  };
}
