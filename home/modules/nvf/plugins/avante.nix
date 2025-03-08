{pkgs, ...}: {
enabled = true;
package = pkgs.vimPlugins.avante-nvim;
setupModule = "avante";
setupOpts = {
vendors = {
  mef-openapi = {
    __inherited_from = "openai";
    endpoint = "https://api.mistral.ai/";
    api_key_name = "MEF_MISTRAL_AI";
    model = "ft:codestral-latest:2d70bb8d:20250227:34918562";
  };
};
};
lazy = false;
}
