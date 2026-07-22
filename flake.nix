{
  description = "my flake templates for various languages and frameworks";

  outputs =
    { self }:
    {
      templates.basic = {
        path = ./basic;
        description = "a basic template for a project";
      };
      templates.rust = {
        path = ./rust;
        description = "a template for a rust project";
      };
      templates.haskell = {
        path = ./haskell;
        description = "a template for a Haskell project";
      };
      templates.default = self.templates.basic;
    };
}
