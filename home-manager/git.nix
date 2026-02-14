{
  programs.git = {
    enable = true;

    userName = "Syu-fu";
    userEmail = "syu-fu@gmail.com";

    signing = {
      key = "1D6505310110B5B8BD33D812ABC41001BC030833";
      signByDefault = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nvim";
    };
  };
}
