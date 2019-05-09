{
  services.xserver = {
    enable = true;
    
    displayManager.lightdm.greeters.mini = {
      enable = true;
      user = meatwallace;
      extraConfig = ''
        [greeter]
        show-password-label = true
        [greeter-theme]
        # background-image = ""
      '';
    };

    windowManager = {
      default = "awesome"

      awesome.enable = true;
    };
  };
};
