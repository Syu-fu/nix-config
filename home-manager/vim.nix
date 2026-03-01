_:
{
  programs.vim = {
    enable = true;
    extraConfig = ''
      " Cursor shape per mode
      let &t_EI = "\e[2 q"
      let &t_SI = "\e[5 q"
      let &t_SR = "\e[4 q"
    '';
  };
}
