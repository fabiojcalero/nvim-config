local jdtls = require("jdtls")
local mason = vim.fn.stdpath("data") .. "/mason"

-- Per-project workspace dir (keeps state isolated)
local root_markers = { "gradlew", "mvnw", ".git", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if not root_dir then return end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

-- Debug bundles (optional but recommended)
local bundles = {}
vim.list_extend(bundles, vim.split(
  vim.fn.glob(mason .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true), "\n"))
vim.list_extend(bundles, vim.split(
  vim.fn.glob(mason .. "/packages/java-test/extension/server/*.jar", true), "\n"))

local config = {
  cmd = {
    "jdtls",
    "-data", workspace_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      configuration = { updateBuildConfiguration = "interactive" },
      format = { enabled = true },
    },
  },
  init_options = {
    bundles = bundles,
  },
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

jdtls.start_or_attach(config)

-- Java-specific keymaps
local map = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { buffer = true, desc = desc })
end
map("<leader>oi", jdtls.organize_imports, "Organize imports")
map("<leader>tc", jdtls.test_class, "Test class")
map("<leader>tm", jdtls.test_nearest_method, "Test method")
map("<leader>ev", jdtls.extract_variable, "Extract variable")
map("<leader>em", jdtls.extract_method, "Extract method")
