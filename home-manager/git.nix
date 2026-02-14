{
  programs.git = {
    enable = true;

    signing = {
      key = "1D6505310110B5B8BD33D812ABC41001BC030833";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Syu-fu";
        email = "syu-fu@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nvim";
    };
  };
}
