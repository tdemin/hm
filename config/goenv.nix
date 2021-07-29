params: let
    dictKey = params.lib.dictKey;
    go = dictKey params.data "go";
    privatePackages = params.lib.optional (go != null) (dictKey go "privatePackages");
    list = params.lib.optionalElse
        (privatePackages != null)
        (builtins.concatStringsSep "," privatePackages) "";
in ''
GOPRIVATE=${list}
''
